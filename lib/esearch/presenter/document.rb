module Esearch
  class Presenter
    # Base class result of document command presenters
    class Document < self

      # Return index name
      #
      # @return [String]
      #
      # @api private
      #
      expose_primitive(:_index, :index)

      # Return type name
      #
      # @return [String]
      #
      # @api private
      #
      expose_primitive(:_type, :type)

      # Return id
      #
      # @return [String]
      #
      # @api private
      #
      expose_primitive(:_id, :id)

      # Return version
      #
      # @return [Fixnum]
      #
      # @api private
      #
      expose_primitive(:_version, :version)

      # Base class for document operations
      class Operation < self

        # Test for successful operation
        #
        # @return [true]
        #   if successful
        #
        # @return [false]
        #   otherwise
        #
        # @api private
        #
        expose_primitive(:ok, :ok?)

        # Index operation
        class Index < self
        end # Index

        # Update operation
        class Update < self
        end # Update

        # Delete operation
        class Delete < self

          # Test if document was found
          #
          # @return [true]
          #   if document was found
          #
          # @return [false]
          #   otherwise
          #
          # @api private
          #
          expose_primitive(:found, :found?)

        end # Delete
      end # Operation

      # Presenter for document get result
      class Get < self

        # Return source document
        #
        # @return [Hash]
        #
        # @api private
        #
        expose_primitive(:_source, :source)

        # Return requested fields
        #
        # @return [Hash]
        #
        # @api private
        #
        expose_primitive(:fields)

      end # Get

    end # Document
  end # Presenter
end # Esearch
