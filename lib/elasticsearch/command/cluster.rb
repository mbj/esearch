module Elasticsearch
  class Command
    # Base class for commands on cluster
    class Cluster < self
      include Composition.new(:connection)

      class Refresh < self

      private

        def response
          connection.post('/_refresh')
        end
      end
    end
  end
end
