# frozen_string_literal: true

require 'xavier/observer'
require 'xavier/version'

# Wraps the gem logic in an accessible way.
module Xavier
  # Raised when attempting to observe a class or instance already under observation.
  AlreadyObserved = Class.new(RuntimeError)

  # Observes an object, yields a block and then reverts the observed object's class and instance variables.
  #
  # @example Observing a class
  #   class EvilSingleton
  #     @@mutated = false
  #     @mutated = false
  #
  #     def self.mutate
  #       @@mutated = true
  #       @mutated = true
  #     end
  #
  #     def self.mutated?
  #       @@mutated && @mutated
  #     end
  #   end
  #
  #   Xavier.observe(EvilSingleton) do
  #     EvilSingleton.mutated? # => false
  #     EvilSingleton.mutate
  #     EvilSingleton.mutated? # => true
  #   end
  #
  #   EvilSingleton.mutated? # => false
  #
  # @example Observing an instance
  #   class InstanceSingleton
  #     def initialize
  #       @mutated = false
  #     end
  #
  #     def mutate
  #       @mutated = true
  #     end
  #
  #     def mutated?
  #       @mutated
  #     end
  #   end
  #
  #   evil_singleton = InstanceSingleton.new
  #
  #   Xavier.observe(evil_singleton) do
  #     evil_singleton.mutated? # => false
  #     evil_singleton.mutate
  #     evil_singleton.mutated? # => true
  #   end
  #
  #   evil_singleton.mutated? # => false
  #
  # @raise [AlreadyObserved] When attempting to observe the same object twice before the block returning.
  #
  # @param observable The object whose state should be observed. It can be a class or an instance.
  #
  # @yield The block to be executed before the observable's state is reverted.
  #
  # @return [Integer] The object_id of the observable.
  #
  # @api public
  def self.observe(observable, &block)
    @observer ||= Observer.new
    @observer.observe(observable, &block)
  end
end
