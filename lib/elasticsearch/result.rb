module Elasticsearch
  # Result of query
  class Result
    include Adamantium::Flat, Enumerable

    # Return facets
    #
    # @return [Hash]
    #
    # @api private
    #
    def facets
      @data.fetch('facets', {}).each_with_object({}) do |(name, body), hash|
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
