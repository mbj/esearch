module Elasticsearch
  # Driver for specific index
  class Index
    include Adamantium::Flat, Composition.new(:connection, :name)

    # Refresh index
    #
    # @api private
    #
    # @return [self]
    #
    def refresh
      Command::Refresh::Index.run(self)
      self
    end

    # Setup index
    #
    # @param [Hash] settings
    #
    # @return [self]
    #
    # @api private
    #
    def setup(settings)
      Command::Setup.run(connection, path, settings)
      self
    end

    # Drop index
    #
    # @return [self]
    #
    # @api private
    #
    def drop
      Command::Drop.run(connection, path)
      self
    end

    # Return result
    #
    # @param [Hash] query
    #
    # @api private
    #
    def read(query)
      Command::Read.run(connection, path, query)
    end

    # Return type for index
    #
    # @param [String] name
    #
    # @return [Type]
    #
    # @api private
    #
    def type(name)
      Type.new(self, name)
    end

  private

    # Return path
    #
    # @return [Pathname]
    #
    # @api private
    #
    def path
      Pathname.new("/#{name}")
    end
    memoize :path

  end
end
