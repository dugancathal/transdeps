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

### Using `rake`

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

### Using `rspec`

Add this spec:

```ruby
require "transdeps/cli"

RSpec.describe "Component" do
  it "uses the same version of dependencies as the ones in the container application" do
    results = Transdeps::Cli.new("components").run
    expect(results).to be_empty, failure_message(results)
  end

  def failure_message(results)
    (["❌  Dependency inconsistencies found:"] + results).join("\n")
  end
end
```

## Contributing

1. Fork it ( https://github.com/dugancathal/transdeps/fork )
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Install gems (`gem install bundler && bundle`)
1. Run tests (`rspec`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request
