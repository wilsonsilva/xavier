<p align="center">
  <img src="https://github.com/wilsonsilva/xavier/raw/master/logo.png">
</p>

<h1 align="center">Xavier</h1>

<p align="center">
  <a href="http://badge.fury.io/rb/xavier">
    <img src="https://badge.fury.io/rb/xavier.svg" alt="Gem Version">
  </a>
  <a href="https://travis-ci.org/wilsonsilva/xavier">
    <img src="https://travis-ci.org/wilsonsilva/xavier.svg?branch=master" alt="Build Status">
  </a>
  <a href="https://codeclimate.com/github/wilsonsilva/xavier/maintainability">
    <img src="https://api.codeclimate.com/v1/badges/7473cd7cdcf12b4bb453/maintainability" alt="Maintainability">
  </a>
  <a href="https://codeclimate.com/github/wilsonsilva/xavier/test_coverage">
    <img src="https://api.codeclimate.com/v1/badges/7473cd7cdcf12b4bb453/test_coverage" alt="Test Coverage">
  </a>
  <a href="http://inch-ci.org/github/wilsonsilva/xavier">
    <img src="http://inch-ci.org/github/wilsonsilva/xavier.svg?branch=master" alt="Inline docs">
  </a>
</p>

Tracks and reverts objects internal state mutations (changes in `instance`, `class`, and `class instance` variables).

## Table of contents

* [Motivation](#motivation)
* [Installation](#installation)
* [Usage](#usage)
* [Development](#development)
* [Contributing](#contributing)

## Motivation

Global state can easily lead to interference between test cases and cause random failures. These issues are called
__mystery guests__, because they effect the behavior of the code being tested however the test method fails to show
that relationship.

In X-men, one of Xavier's goals is to protect society from antagonistic mutants.

In Ruby, one of Xavier's goals is to protect test cases from failures caused by mystery guests.

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
  EvilSingleton.mutated? # => false. This is the starting state of the class.
  EvilSingleton.mutate
  EvilSingleton.mutated? # => true. This is the mutation that we will revert.
end

EvilSingleton.mutated? # => false. All the internal state is reverted.
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

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive
prompt that will allow you to experiment. The health and maintainability of the codebase is ensured through a set of
Rake tasks to test, lint and audit the gem for security vulnerabilities and documentation:

```
rake rubocop               # Lint the codebase with RuboCop
rake rubocop:auto_correct  # Auto-correct RuboCop offenses
rake spec                  # Run RSpec code examples
rake verify_measurements   # Verify that yardstick coverage is at least 100%
rake yard                  # Generate YARD Documentation
rake yard:junk             # Check the junk in your YARD Documentation
rake yardstick_measure     # Measure docs in lib/**/*.rb with yardstick
```

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wilsonsilva/xavier.
