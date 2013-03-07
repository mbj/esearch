module Elasticsearch
  # Driver for specific index
  class Index
    include Adamantium::Flat, Composition.new(:connection, :name)
    include Exist

    # Refresh index
    #
    # @api private
    #
    # @return [self]
    #
    def refresh
      Command::Index::Refresh.run(self)
      self
    end

    # Cretate remote index
    #
    # @param [Hash] settings
    #
    # @return [self]
    #
    # @api private
    #
    def create(settings)
      Command::Index::Create.run(self, settings)
      self
    end

    # Delete remote index
    #
    # @return [self]
    #
    # @api private
    #
    def delete
      Command::Index::Delete.run(self)
      self
    end

    # Return result
    #
    # @param [Hash] query
    #
    # @api private
    #
    def read(query)
      Command::Read.run(self, query)
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
