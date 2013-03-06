module Elasticsearch
  # Handler for document
  class Document
    include Adamantium::Flat, Composition.new(:type, :id)

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

    # Delete document
    #
    # @return [Presenter::Command::Document::Delete]
    #
    # @api private
    #
    def delete
      Command::Document::Delete.run(self)
    end

    # Index document
    #
    # @param [Hash] document
    # @param [Hash] options
    #
    # @return [Presenter::Command::Document::Index]
    #
    # @api private
    #
    def index(document, options = {})
      Command::Document::Index.run(self, document, options)
    end

    # Return document
    #
    # @return [Presenter::Command::Document::Get]
    #
    # @api private
    #
    def get
      Command::Document::Get.run(self)
    end

    # Return path
    #
    # @return [Pathname]
    #
    # @api private
    #
    def path
      type.path.join(id)
    end
    memoize :path

    # Return connection
    #
    # @return [Connection]
    #
    # @api private
    #
    def connection
      type.connection
    end

  end
end
