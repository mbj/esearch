module Elasticsearch
  # Abstract base class for operations
  class Operation
    include Adamantium::Flat, AbstractClass

    # Abstract base class for nullary operations
    class Nullary < self
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
