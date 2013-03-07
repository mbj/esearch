module Elasticsearch
  # Handler for set of indices
  class Indices
    include Adamantium::Flat, Composition.new(:connection, :names)
    include Mixin::Exist, Mixin::Index, Mixin::Search

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
