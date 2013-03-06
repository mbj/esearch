module Elasticsearch
  class Command
    # Drop command
    class Drop < self
      include Composition.new(:connection, :path)

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
        connection.delete(path.to_s)
      end
    end
  end
end
