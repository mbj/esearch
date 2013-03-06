module Elasticsearch
  class Command
    # Setup command
    class Setup < self
      include Composition.new(:connection, :path, :settings)

      EXPECT_STATUS = [ Response::Status::CREATED ].freeze

    private

      # Return response
      #
      # @return [Faraday::Response]
      #
      # @api private
      #
      def response
        connection.put(path.to_s) do |request|
          request.body = MultiJson.dump(settings)
        end
      end
    end
  end
end
