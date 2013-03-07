module Elasticsearch
  # Interface to a specific elasticsearch type
  class Type
    include Adamantium::Flat, Composition.new(:es_index, :name)

    # Test if index does exist
    #
    # @return [true]
    #   if index exists
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def exist?
      Command::Exist.run(self)
    end

    # Index document
    #
    # @param [Document] document
    # @param [Hash] options
    #
    # @return [Presenter::Operation::Index]
    #
    # @api private
    #
    def index(document, options = {})
      Command::Document::Index.run(self, document, options)
    end

    # Create indexed document
    #
    # @param [Document] document
    # @param [Hash] options
    #
    # @api private
    #
    def index_create(document, options = {})
      Command::Document::Index::Create.run(self, document, options)
    end

    # Update indexed document
    #
    # @param [Document] document
    # @param [Hash] options
    #
    # @api private
    #
    def index_update(document, options = {})
      Command::Document::Index::Create.run(self, document, options)
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
  end
end
