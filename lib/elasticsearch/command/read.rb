module Elasticsearch
  class Command
    class Read < self
      include Composition.new(:connection, :path, :query)

      def result
        assert_success
        Result.new(parsed_json)
      end

    private

      def response
        connection.get(path.join('_search').to_s, query)
      end
    end
  end
end

