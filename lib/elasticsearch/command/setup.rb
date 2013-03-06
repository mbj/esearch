module Elasticsearch
  class Command
    # Setup command
    class Setup < self
      include Composition.new(:subject, :settings)

      EXPECT_STATUS = [ Response::Status::CREATED ].freeze

    private

      # Return response
      #
      # @return [Faraday::Response]
      #
      # @api private
      #
      def response
        connection.put(subject.path, settings)
      end
    end
  end
end
