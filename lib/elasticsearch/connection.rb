module Elasticsearch
  # Interaction endpoint for an elasticsearch cluster
  class Connection

    include Adamantium::Flat, Composition.new(:connection)

    # Return index with name
    #
    # @param [String] name
    #
    # @return [Index]
    #
    # @api private
    #
    def index(name)
      Index.new(connection, name)
    end

    # Return all indices object
    #
    # @return [All]
    #
    # @api private
    #
    def all_indices
      Indices::All.new(connection)
    end
    memoize :all_indices

    # Build connection
    #
    # @param [String] uri
    #   the uri of the elasticsearch node to connect
    #
    # @return [Connection]
    #
    # @api private
    #
    def self.build(uri)
      new(Faraday.new(uri))
    end

  end
end
