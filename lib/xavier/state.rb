# frozen_string_literal: true

module Xavier
  # A storage for an observed class or object's internal state.
  # @api private
  class State < BasicObject
    # Returns the object id of the observed object
    #
    # @return [Integer] The +object_id+ of the observed object.
    attr_reader :observed_object_id

    # Creates a new state representation.
    #
    # @param [Integer] observed_object_id The +object_id+ of the observed object.
    def initialize(observed_object_id)
      @observed_object_id = observed_object_id
      @class_variables = {}
      @instance_variables = {}
    end

    # Sets the instance variable named by +name+ to the given object.
    #
    # @param [String|Symbol] name Name of the instance variable.
    # @param value Value of the instance variable.
    #
    # @return The value of the given instance variable.
    def instance_variable_set(name, value)
      @instance_variables[name.to_sym] = value
    end

    # Returns the value of the given instance variable, or +nil+ if the instance variable is not set.
    #
    # @param [String|Symbol] name Name of the instance variable.
    #
    # @return The value of the given instance variable.
    def instance_variable_get(name)
      @instance_variables[name.to_sym]
    end

    # Sets the class variable named by +name+ to the given object.
    #
    # @param [String|Symbol] name Name of the instance variable.
    # @param value Value of the instance variable.
    #
    # @return The value of the given class variable.
    def class_variable_set(name, value)
      @class_variables[name.to_sym] = value
    end

    # Returns the value of the given class variable, or nil if the class variable is not set.
    #
    # @param [String|Symbol] name Name of the class variable.
    #
    # @return The value of the given class variable.
    def class_variable_get(name)
      @class_variables[name.to_sym]
    end

    # Returns true if class is the class of +self+, or if +clazz+ is one of the superclasses of +self+ or modules.
    #
    # @return [Boolean] Whether the given class is the class, superclass or modules of +self+.
    def is_a?(clazz)
      return true if clazz == ::Class

      self.class == clazz
    end

    # Returns the class +State+.
    #
    # @return [State] The class +State+.
    def class
      State
    end

    # Returns an array of instance variable names for the receiver.
    #
    # @return [Array<Symbol>] Array of instance variable names.
    def instance_variables
      @instance_variables.keys
    end

    # Returns an array of the names of class variables in mod.
    #
    # @return [Array<Symbol>] Array of class variable names.
    def class_variables
      @class_variables.keys
    end
  end
end
