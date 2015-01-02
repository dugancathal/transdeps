# Transdeps

A gem to find inconsistent dependency versions in component-based
Ruby apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'transdeps'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install transdeps

## Usage

Add this line to application's Rakefile:

```ruby
require 'transdeps/tasks'
```

Then run:

```bash
bundle exec rake[/path/to/my/components,/path/to/my/project]
```

Since you are presumably running this task from the root of your project,
you can leave the second argument to the Rake task off, and the
first argument would be a relative path. Something like:

```bash
bundle exec rake[components]
```

## Contributing

1. Fork it ( https://github.com/dugancathal/transdeps/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
