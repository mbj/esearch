module Elasticsearch
  # Handle for an elasticsearch cluster
  class Cluster

    include Adamantium::Flat, Composition.new(:connection)

    # Return handler for index
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

    # Return handler for indices
    #
    # @param [Enumerable<String>] names
    #
    # @return [Indices]
    #
    # @api private
    #
    def indices(names)
      Indices.new(connection, names)
    end

    # Return present indexes
    #
    # @param [Enumerable<Index>]
    #
    # @api private
    #
    def present_indices
      all_indices.status.indices.map do |index|
        self.index(index.name)
      end
    end

    # Return cluster health
    #
    # @param [Hash] options
    #
    # @return [Presenter::Health]
    #
    # @api private
    #
    def health(options = {})
      Command::Cluster::Health.run(self, options)
    end

    # Return path
    #
    # @return [Pathname]
    #
    # @api private
    #
    def path
      self.class::PATH
    end

    PATH = Pathname.new('/')

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
    # @return [Connection]
    #
    # @api private
    #
    def self.connect(*args)
      new(Connection.build(*args))
    end

  end
end
