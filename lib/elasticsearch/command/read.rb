module Elasticsearch
  class Command
    class Read < self
      include Composition.new(:connection, :path, :query)

      # Return result
      #
      # @return [Result]
      #
      # @api private
      #
      def result
        assert_success
        Result.new(parsed_json)
      end

    private

      # Return response
      #
      # @return [Faraday::Response]
      #
      # @api private
      #
      def response
        connection.get(path.join('_search').to_s, query)
      end
    end
  end
end

