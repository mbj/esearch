module Elasticsearch
  class Result
    class Aspect

      # Aspect of a term facet
      class Term < self

        # Return value of aspect
        #
        # @return [String]
        #
        # @api private
        #
        def value
          @data.fetch('term')
        end
        memoize :value

      end
    end
  end
end
