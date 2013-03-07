module Elasticsearch
  # Handler for set of indices
  class Indices
    include Adamantium::Flat, Composition.new(:connection, :names)
    include Exist

    # Return path
    #
    # @return [Pathname]
    #
    # @api private
    #
    def path
      Pathname.new("/#{names.join(',')}")
    end
    memoize :path

    # Refresh cluster
    #
    # @return [self]
    #
    # @api private
    #
    def refresh
      Command::Index::Refresh.run(self)
      self
    end

    # Return status of cluster
    #
    # @return [Status]
    #
    # @api private
    #
    def status
      Command::Index::Status.run(self)
    end

    # Read from indices
    #
    # @param [Hash] query
    #
    # @return [Presenter::Result]
    #
    # @api private
    #
    def read(query)
      Command::Read.run(self, query)
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
