module Elasticsearch
  class Command
    # Base class for cluster commands
    class Cluster < self

      # Command for accessing health
      class Health < self
        include Composition.new(:subject, :options)

        PRESENTER = Presenter::Cluster::Health

        # Return response
        #
        # @return [Faraday::Response]
        #
        # @api private
        #
        def response
          connection.get('/_cluster/health', {}, options)
        end
        memoize :response

      end

    end
  end
end
