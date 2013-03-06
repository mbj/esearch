module Elasticsearch
  class Presenter
    # Presenter for query result
    class Result < self

      # Return facets
      #
      # @return [Hash]
      #
      # @api private
      #
      def facets
        raw.fetch('facets', {}).each_with_object({}) do |(name, body), hash|
          hash[name] = Facet.build(body)
        end
      end
      memoize :facets

      # Return hits
      #
      # @return [Enumerable<Hash>]
      #
      # @api private
      #
      def hits
        Hits.new(raw.fetch('hits'))
      end
      memoize :hits

    end
  end
end
