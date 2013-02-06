module Elasticsearch
  # Result of query
  class Result
    include Adamantium::Flat, Enumerable, Composition.new(:data)

    # Return facets
    #
    # @return [Hash]
    #
    # @api private
    #
    def facets
      data.fetch('facets', {}).each_with_object({}) do |(name, body), hash|
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
      Hits.new(data.fetch('hits'))
    end
    memoize :hits

  end
end
