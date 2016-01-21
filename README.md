# RbSafe

Check the password's strength for you. It's a ruby port for the original python
implementation: [safe](https://github.com/lepture/safe)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rb_safe'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rb_safe

## Usage

```ruby
> RbSafe.check(1)
=> terrible
> RbSafe.check('password')
=> simple
> RbSafe.check('is.safe.password')
=> medium
> RbSafe.check('x*V-92Ba')
=> strong
> password = RbSafe.check('x*V-92Ba')
> p password
strong
> puts password
password is perfect
> password.valid
=> true
> password.strength
=> "strong"
> password.message
=> "password is perfect"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lord63/rb_safe.

## Kudos

All the glories should belong to @lepture, I just port it to ruby :)

## License

MIT.
