# frozen_string_literal: true

module Xavier
  module MutationStrategies
    # Copies the instance variables from one object to other.
    #
    # @api private
    module InstanceCopy
      # Copies the instance variables from one object to other.
      #
      # @param from An object where the state will be copied from.
      # @param to An object where the state will be copied to.
      #
      # @return [Array<String>] A list of variable names that were copied.
      def self.copy(from:, to:)
        vars = from.instance_variables.map(&:to_s)
        vars.each { |name| to.instance_variable_set(name, from.instance_variable_get(name)) }
      end
    end
  end
end
