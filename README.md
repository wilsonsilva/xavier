# Xavier

[![Gem Version](https://badge.fury.io/rb/xavier.svg)](http://badge.fury.io/rb/xavier)
[![Build Status](https://travis-ci.org/wilsonsilva/xavier.svg?branch=master)](https://travis-ci.org/wilsonsilva/xavier)

Xavier tracks and reverts state mutations (changes in `instance`, `class`, and `class instance` variables).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xavier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xavier

## Usage

Observing a class:

```ruby
class EvilSingleton
  @@mutated = false
  @mutated = false

  def self.mutate
    @@mutated = true
    @mutated = true
  end

  def self.mutated?
    @@mutated && @mutated
  end
end

Xavier.observe(EvilSingleton) do
  EvilSingleton.mutated? # => false
  EvilSingleton.mutate
  EvilSingleton.mutated? # => true
end

EvilSingleton.mutated? # => false
```

Observing an instance:

```ruby
class InstanceSingleton
  def initialize
    @mutated = false
  end

  def mutate
    @mutated = true
  end

  def mutated?
    @mutated
  end
end

evil_singleton = InstanceSingleton.new

Xavier.observe(evil_singleton) do
  evil_singleton.mutated? # => false
  evil_singleton.mutate
  evil_singleton.mutated? # => true
end

evil_singleton.mutated? # => false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.
You can also run:
* `bin/console` for an interactive prompt that will allow you to experiment.
* `rake rubocop` to lint the code.
* `rake verify_measurements` to generate a report of the Yard documentation.
* `rake yard:junk` to lint the Yard documentation. 

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/xavier.
