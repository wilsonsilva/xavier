# frozen_string_literal: true

require 'xavier/mutator'
require 'xavier/states'

module Xavier
  # Observes an object for state mutations.
  #
  # @api private
  class Observer
    # Creates an instance of +Observer+.
    #
    # @param [Mutator] mutator Applies and unapplies state modifications.
    # @param [States] states States of objects under observation. Empty by default.
    def initialize(mutator = Mutator.new, states = States.new)
      @states = states
      @mutator = mutator
    end

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
    # @api private
    def observe(observable)
      raise ArgumentError, 'This method expects a block. Without a block it is useless.' unless block_given?
      raise AlreadyObserved, 'Objects can only be observed once per block.' if being_observed?(observable)

      strategies = mutator.mutation_strategies_for(observable)
      original_state = mutator.create_state_from(observable, strategies: strategies)
      save_state(original_state)

      yield

      mutator.apply_state(from: original_state, to: observable, strategies: strategies)
      delete_state(original_state)
    end

    private

    # Returns the state mutator.
    #
    # @return [Xavier::Mutator] Applies and unapplies state modifications.
    attr_reader :mutator

    # Returns the observed objects states.
    #
    # @return [Xavier::States] States of objects under observation. Used to revert the object to its original state.
    attr_reader :states

    # Returns whether the given +observable+ is already under observation.
    #
    # @param observable A class or instance to be checked.
    #
    # @return [Boolean] Whether the object is being observed.
    def being_observed?(observable)
      states.contain?(observable.object_id)
    end

    # Stores a state representation of an observable.
    #
    # @param [State] state The state to be stored.
    #
    # @return [States] The whole states collection.
    def save_state(state)
      states.add(state)
    end

    # Deletes the state representation of an observable.
    #
    # @param [State] state State representation of an object under observation.
    #
    # @return [Integer] The object_id of the observable.
    def delete_state(state)
      states.remove(state)
    end
  end
end
