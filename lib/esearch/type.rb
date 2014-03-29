module Esearch
  # Interface to a specific elasticsearch type
  class Type
    include Adamantium::Flat, Concord.new(:es_index, :name)
    include Mixin::Exist, Mixin::Document, Mixin::Search

    # Return document handler
    #
    # @param [String] id
    #
    # @return [Document]
    #
    # @api private
    #
    def document(id)
      Document.new(self, id)
    end

    # Return connection
    #
    # @return [Faraday::Connection]
    #
    # @api private
    #
    def connection
      es_index.connection
    end

    # Return path
    #
    # @return [Pathname]
    #
    # @api private
    #
    def path
      es_index.path.join(name)
    end
    memoize :path

  end # Type
end # Esearch
