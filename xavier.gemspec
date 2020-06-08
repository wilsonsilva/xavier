# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'xavier/version'

Gem::Specification.new do |spec|
  spec.name          = 'xavier'
  spec.version       = Xavier::VERSION
  spec.authors       = ['Wilson Silva']
  spec.email         = ['me@wilsonsilva.net']

  spec.summary       = 'Reverts state mutations.'
  spec.description   = 'Reverts state mutations.'
  spec.homepage      = 'https://github.com/wilsonsilva/xavier'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.metadata['yard.run'] = 'yri' # use "yard" to build full HTML docs.

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.85'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.39'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'yard-junk', '~> 0.0.7'
  spec.add_development_dependency 'yardstick', '~> 0.9'
end
