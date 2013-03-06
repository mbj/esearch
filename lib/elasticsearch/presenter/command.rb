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

    end
  end
end
