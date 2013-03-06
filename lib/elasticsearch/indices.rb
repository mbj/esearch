module Elasticsearch
  # A set of indices to issue commands on
  class Indices
    include Adamantium::Flat, Composition.new(:connection, :indices)

    # Return path
    #
    # @return [Pathname]
    #
    # @api private
    #
    def path
      Pathname.new("/#{indices.join(',')}")
    end
    memoize :path

    # Refresh cluster
    #
    # @return [self]
    #
    # @api private
    #
    def refresh
      Command::Refresh.run(connection, path)
      self
    end

    # Read from indices
    #
    # @return [Result]
    #
    # @api private
    #
    def read(query)
      Command::Reader.new(connection, path, query)
    end

    # Return tuples from query
    #
    # @param [Hash] query
    #   the query in elasticsearch format as a hash
    #
    # @api private
    #
    # @return [Result]
    #
    def read(query)
      Command::Read.run(connection, path, query)
    end

    # Control all indices of a cluster
    class All < self
      include Composition.new(:connection)

      # Return path
      #
      # @return [Pathname]
      #
      # @api private
      #
      def path
        self.class::PATH
      end

      PATH = Pathname.new('/_all').freeze

    end
  end
end
