require "bitroles/version"

module Bitroles
  extend ActiveSupport::Concern

  included do
    scope :with_role, -> role { where("#{mask_column_name} & #{2**roles.index(role.to_s)} > 0") }
  end

  module ClassMethods
    def roles(*args)
      if args.any?
        if args.last.is_a?(Hash)
          options = args.pop if args.last.is_a?(Hash)
          @@mask_column_name = options[:mask_column].to_s
        end
        @@roles = args.map(&:to_s)
      else
        @@roles
      end
    end

    def mask_column_name
      defined?(@@mask_column_name) ? @@mask_column_name : 'roles_mask'
    end
  end

  def method_missing(method_sym, *arguments, &block)
    roles = self.class.roles.join('|')
    if method_sym.to_s =~ /^is_(#{roles})\?$/
      role? $1
    else
      super
    end
  end

  def roles=(roles)
    roles = (roles.map(&:to_s) & self.class.roles).map { |r| 2**self.class.roles.index(r) }.sum
    self.send("#{self.class.mask_column_name}=", roles)
  end

  def roles
    self.class.roles.reject { |r| ((send(self.class.mask_column_name) || 0) & 2**self.class.roles.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end
end
