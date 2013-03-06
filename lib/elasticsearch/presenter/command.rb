module Elasticsearch
  class Presenter
    class Command < self

      # Test for successful execution
      #
      # @return [true]
      #   if command was successful
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      expose_primitive(:ok, :ok?)

      # Base class for result of index command class presenters
      class Index < self

        class Create < self
        end

        class Delete < self
        end

      end
      
      class Refresh < self
      end

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

        class Index < self
        end

        class Update < self
        end

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

        end

      end
    end
  end
end
