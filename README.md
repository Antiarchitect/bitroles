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
  roles :admin, :moderator
end
```
By default bitroles uses roles_mask integer column in your table to store the roles. You can change column name pretty
easy:

```ruby
class MyModel < ActiveRecord::Base
  roles :admin, :moderator, mask_column: :someothercolumn
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
