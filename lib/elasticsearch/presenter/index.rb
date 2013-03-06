module Elasticsearch
  class Presenter

    # Base class for index operation result presenters
    class Index < self

      # Mixin to define #ok?
      module Okay
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
        def ok?
          raw.fetch('ok')
        end
      end

      # Create operation presenter
      class Create < self
        include Okay
      end

      # Delete operation presenter
      class Delete < self
        include Okay
      end
      
      # Refresh operation presenter
      class Refresh < self
      end

    end
  end
end
