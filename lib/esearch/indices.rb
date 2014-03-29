# encoding: UTF-8

module Esearch
  # Handler for set of indices
  class Indices
    include Adamantium::Flat, Concord.new(:connection, :names)
    include Mixin::Exist, Mixin::Index, Mixin::Search

    # Return connection
    #
    # @return [Connection]
    #
    # @api private
    #
    attr_reader :connection

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
      include Concord.new(:connection)

      PATH = Pathname.new('/_all').freeze

      # Return connection
      #
      # @return [Connection]
      #
      # @api private
      #
      attr_reader :connection

      # Return path
      #
      # @return [Pathname]
      #
      # @api private
      #
      def path
        PATH
      end

    end # All
  end # Indices
end # Esearch
