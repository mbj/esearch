module Elasticsearch
  class Result

    # Abstract base class of an aspect of a facet
    class Aspect
      include Adamantium::Flat, AbstractType

      # Return count of occurences of aspect in facet
      #
      # @return [Fixnum]
      #
      # @api private
      #
      def count
        @data.fetch('count')
      end

    private

      # Initialize object
      #
      # @param [Hash] data
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(data)
        @data = data
      end
    end
  end
end
