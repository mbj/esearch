module Elasticsearch
  class Result

    # Abstract base class of an aspect of a facet
    class Aspect
      include Adamantium::Flat, AbstractType, Composition.new(:data)

      # Return count of occurences of aspect in facet
      #
      # @return [Fixnum]
      #
      # @api private
      #
      def count
        data.fetch('count')
      end

    end
  end
end
