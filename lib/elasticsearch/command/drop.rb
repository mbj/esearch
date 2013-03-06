module Elasticsearch
  class Command
    # Drop command
    class Drop < self

    private

      # Return response
      #
      # @return [Faraday::Response]
      #
      # @api private
      #
      def response
        connection.delete(subject.path)
      end
    end
  end
end
