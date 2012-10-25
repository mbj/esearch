module Elasticsearch
  class Result
    include Adamantium, Enumerable

    # Return facets
    #
    # @return [Enumerable<Facet>]
    #
    # @api private
    #
    def facets
      FacetSet.new(@data.fetch('facets', {}))
    end

    # Return hits
    #
    # @return [Enumerable<Hash>]
    #
    # @api private
    #
    def hits
      Hits.new(@data.fetch('hits'))
    end
    memoize :hits

  private

    # Initialize result
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
