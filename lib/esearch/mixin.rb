# encoding: UTF-8

module Esearch
  # Namespace for handler mixins
  module Mixin

    # Mixin for exist predicate
    module Exist

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

    end # Exist

    # Mixin that adds document operations
    module Document

      # Index document
      #
      # @param [Document] document
      # @param [Hash] options
      #
      # @return [Presenter::Document::Operation::Index]
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
      # @return [Presenter::Document::Operation::Index]
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
      # @return [Presenter::Document::Operation::Index]
      #
      # @api private
      #
      def index_update(document, options = {})
        Command::Document::Index::Update.run(self, document, options)
      end

    end # Document

    # Mixin that adds index commands
    module Index

      # Refresh cluster
      #
      # @return [self]
      #
      # @api private
      #
      def refresh
        Command::Index::Refresh.run(self)
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

    end # Index

    # Mixin for search command
    module Search

      # Return result
      #
      # @param [Hash] query
      #
      # @return [Presenter::Search]
      #
      # @api private
      #
      def search(query)
        Command::Search.run(self, query)
      end

    end # Search

  end # Mixin
end # Esearch
