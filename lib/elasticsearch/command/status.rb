module Elasticsearch
  class Command

    # Command to return cluster status
    class Status < self
      include Composition.new(:subject)

      PRESENTER = Presenter::Status

    private

      # Return response
      #
      # @return [Faraday::Response]
      #
      # @api private
      #
      def response
        connection.get(subject_path.join('_status'))
      end
      memoize :response

      # Return connection
      #
      # @api private
      #
      def connection
        subject.connection
      end

    end
  end
end
