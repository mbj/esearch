module Elasticsearch
  class Result
    class Facet
      # Facet that returns range counts
      class Range < self
        register 'range'

        # Return range aspects
        #
        # @return [Enumerable<Aspect::Range>]
        #
        # @api private
        #
        def aspects
          @data.fetch('ranges').map do |range|
            Aspect::Range.new(range)
          end
        end
        memoize :aspects
      end
    end
  end
end
