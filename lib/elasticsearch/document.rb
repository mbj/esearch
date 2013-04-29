module Elasticsearch
  # Handler for document
  class Document
    include Adamantium::Flat, Concord.new(:type, :id)
    include Mixin::Exist, Mixin::Document

    # Delete document
    #
    # @return [Presenter::Command::Document::Delete]
    #
    # @api private
    #
    def delete
      Command::Document::Delete.run(self)
    end

    # Return document
    #
    # @return [Presenter::Command::Document::Get]
    #   if foundd
    #
    # @return [nil]
    #   otherwise
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
