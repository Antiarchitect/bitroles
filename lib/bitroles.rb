require "bitroles/version"

module Bitroles
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def has_roles(*args)
      if args.any?
        roles_mask = 'roles_mask'
        if args.last.is_a?(Hash)
          options = args.pop if args.last.is_a?(Hash)
          roles_mask = options[:mask_column].to_s
        end
        roles = args.map(&:to_s)

        class_eval <<-EVAL, __FILE__, __LINE__
          def self.roles
            #{roles}
          end

          def roles=(roles)
            roles = (roles.map(&:to_s) & #{roles}).map { |r| 2**#{roles}.index(r) }.sum
            self.#{roles_mask} = roles
          end

          def roles
            #{roles}.reject { |r| ((#{roles_mask} || 0) & 2**#{roles}.index(r)).zero? }
          end

          def has_role?(role)
            roles.include? role.to_s
          end
        EVAL

        roles.each do |role|
          class_eval <<-EVAL, __FILE__, __LINE__
            scope :#{role.pluralize}, -> { where(['#{roles_mask} & ? > 0', 2**#{roles}.index('#{role}')]) }

            def is_#{role}?
              role? role
            end

            def #{role}=(val)
              if val
                self.roles += [#{role}] unless has_role? #{role}
              else
                self.roles -= [#{role}] if has_role? #{role}
              end
            end
          EVAL
        end
      end
    end
  end
end

class ActiveRecord::Base
  include Bitroles
end
