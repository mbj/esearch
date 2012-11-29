module Elasticsearch
  # Abstract base class for operations
  class Operation
    include Adamantium::Flat, AbstractType

    # Abstract base class for nullary operations
    class Nullary < self

      # Intialize object
      #
      # @param [Hash] document
      #
      # @api private
      #
      def initialize(document)
        @document = document
      end

      # Create operation
      class Create < self
      end

      # Update operation
      class Update < self
      end
    end
  end
end
