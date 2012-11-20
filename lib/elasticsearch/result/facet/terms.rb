module Elasticsearch
  class Result
    class Facet
      # Facet that returns term counts
      class Terms < self
        register 'terms'

        def size
          aspects.size
        end

        def aspects
          @data.fetch('terms').map do |term|
            Aspect::Term.new(term)
          end
        end
        memoize :aspects
      end
    end
  end
end
