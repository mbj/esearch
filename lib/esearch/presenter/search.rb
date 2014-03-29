module Esearch
  class Presenter
    # Presenter for search result
    class Search < self

      # Return facets
      #
      # @return [Hash]
      #
      # @api private
      #
      def facets
        raw.fetch('facets', {}).each_with_object({}) do |(name, body), aggregate|
          aggregate[name] = Facet.build(body)
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

    end # Search
  end # Presenter
end # Esearch
