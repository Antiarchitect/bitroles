# Bitroles

Simple roles for your models without external tables

## Installation

Add this line to your application's Gemfile:

    gem 'bitroles'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitroles

## Usage

```ruby
class MyModel < ActiveRecord::Base
  has_roles :admin, :moderator
end
```
By default bitroles uses roles_mask integer column in your table to store the roles. You can change column name pretty
easy:

```ruby
class MyModel < ActiveRecord::Base
  has_roles :admin, :moderator, mask_column: :someothercolumn
end
```
## Available methods

```ruby
objects = MyModel.with_role(:admin) # Finds all MyModel objects with admin role
obj = objects.first
obj.has_role? :admin # Checks if the object has admin role
obj.is_admin? # Checks the above. It can be is_moderator? or is_whatever? depends on roles given to has_role
obj.roles # Shows all roles of object (strings array)
obj.roles = [:admin, :moderator] # Sets admin and moderator role to obj
obj.admin = true # obj became admin (same for other roles)
obj.admin = false # obj is no longer an admin (same for other roles)

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
