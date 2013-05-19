module Esearch
  # Driver for specific index
  class Index
    include Adamantium::Flat, Concord.new(:connection, :name)
    include Mixin::Exist, Mixin::Search, Mixin::Index

    # Return connection
    #
    # @return [Connection]
    #
    # @api private
    #
    attr_reader :connection

    # Cretate remote index
    #
    # @param [Hash] settings
    #
    # @return [Presenter::Index::Create]
    #
    # @api private
    #
    def create(settings)
      Command::Index::Create.run(self, settings)
    end

    # Delete remote index
    #
    # @return [Presenter::Index::Delete]
    #
    # @api private
    #
    def delete
      Command::Index::Delete.run(self)
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
