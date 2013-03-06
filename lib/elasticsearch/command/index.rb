module Elasticsearch
  class Command
    # Base class for commands on indexes
    class Index < self
      include Composition.new(:index)

    private

      # Return connection
      #
      # @return [Connection]
      #
      # @api private
      #
      def connection
        index.cluster.connection
      end

      class Refresh < self

        # Return response
        #
        # @api private
        #
        def response
          connection.post(index.path.join('_refresh'))
        end

      end
    end
  end
end
