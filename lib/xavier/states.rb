# frozen_string_literal: true

module Xavier
  # Collection of state representations of objects under observation.
  #
  # @api private
  class States
    # Creates an instance of States.
    def initialize
      @collection = {}
    end

    # Stores the state representation of an object.
    #
    # @param [State] state State representation of an object under observation.
    #
    # @return [States] The whole states collection.
    def add(state)
      collection[state.observed_object_id] = state
      self
    end

    # Deletes the state representation of an object.
    #
    # @param [State] state State representation of an object under observation.
    #
    # @return [Integer] The object_id of the observable.
    def remove(state)
      collection.delete(state.observed_object_id)
    end

    # Returns whether the states collection contains a state representation of an object, using its unique object_id.
    #
    # @param [Integer] object_id The object_id of the observable.
    #
    # @return [Boolean] Whether the states collection contains a state representation of an object.
    def contain?(object_id)
      collection.key?(object_id)
    end

    private

    # Returns a hash where the state representations are stored.
    # @return [Hash] A hash where the state representations are stored.
    attr_reader :collection
  end
end
