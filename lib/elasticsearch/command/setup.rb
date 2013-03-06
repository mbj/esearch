module Elasticsearch
  class Command
    class Setup < self
      include Composition.new(:connection, :path, :settings)

      EXPECT_STATUS = [ Response::Status::CREATED ].freeze

    private

      def response
        p path
        connection.put(path.to_s) do |request|
          request.body = MultiJson.dump(settings)
        end
      end
    end
  end
end
