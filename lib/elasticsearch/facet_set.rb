module Elasticsearch

  # Set of facets in results
  class FacetSet
    include Enumerable, Adamantium, Equalizer.new(:to_a)

    # Enumerate facets
    #
    # @return [self]
    #   if block given
    #
    # @return [Enumerator<Facet>]
    #   otherwise
    #
    # @api private
    #
    def each
      return to_enum unless block_given?

      @data.each do |name, body|
        yield Facet.new(name, body)
      end

      self
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
