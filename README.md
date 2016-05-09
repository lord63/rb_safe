# RbSafe

[![Latest Version][1]][2]
[![Build Status][3]][4]
[![Coverage Status][5]][6]

Check the password's strength for you. It's a ruby port for the original python
implementation: [safe][]

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

And you can custom these environment variables:

    RUBY_SAFE_WORDS_CACHE: cache words in this file, default is a tempfile
    RUBY_SAFE_WORDS_FILE: words vocabulary file, default is the 10k top passwords

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to [rubygems.org][].

## Contributing

* It sucks? Why not help me improve it? Let me know the bad things.
* Want a new feature? Feel free to file an issue for a feature request.
* Find a bug? Open an issue please, or it's better if you can send me a pull request.

Contributions are always welcome at any time! :sparkles: :cake: :sparkles:
Bug reports and pull requests are welcome on GitHub at [lord63/rb_safe][].

## Kudos

All the glories should belong to [@lepture][], I just port it to ruby :)

## License

MIT.

[1]: https://badge.fury.io/rb/rb_safe.svg
[2]: http://badge.fury.io/rb/rb_safe
[3]: https://travis-ci.org/lord63/rb_safe.svg?branch=master
[4]: https://travis-ci.org/lord63/rb_safe
[5]: https://codecov.io/github/lord63/rb_safe/coverage.svg?branch=master
[6]: https://codecov.io/github/lord63/rb_safe?branch=master
[safe]: https://github.com/lepture/safe
[rubygems.org]: https://rubygems.org
[lord63/rb_safe]: https://github.com/lord63/rb_safe
[@lepture]: https://github.com/lepture
