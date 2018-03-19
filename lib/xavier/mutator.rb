# frozen_string_literal: true

require 'xavier/state'
require 'xavier/mutation_strategies/class_copy'
require 'xavier/mutation_strategies/instance_copy'

module Xavier
  # Applies and unapplies state mutations to objects.
  #
  # @api private
  class Mutator
    # Returns a state representation from a given +observable+.
    #
    # @param observable The class or instance to copy the state from.
    # @param [Array] strategies Array of mutation mutation_strategies that define how the state should be copied.
    #
    # @return [State] The state representation of the given +observable+
    def create_state_from(observable, strategies:)
      state = State.new(observable.object_id)
      strategies.each { |strategy| strategy.copy(from: observable, to: state) }
      state
    end

    # Applies the given +state+ to the given +observable+.
    #
    # @param from An object where the state will be copied from.
    # @param to An object where the state will be copied to.
    # @param [Array] strategies Array of mutation mutation_strategies that define how the state should be copied.
    #
    # @return [Array] An array of mutation_strategies.
    def apply_state(from:, to:, strategies:)
      strategies.each { |strategy| strategy.copy(from: from, to: to) }
    end

    # Finds the mutation mutation_strategies for a given +observable+.
    #
    # @param observable Any class or instance
    #
    # @return [Array] An array of mutation mutation_strategies that define how the state should be copied.
    def mutation_strategies_for(observable)
      [MutationStrategies::InstanceCopy].tap do |strategies|
        strategies.push(MutationStrategies::ClassCopy) if observable.is_a?(Class)
      end
    end
  end
end
