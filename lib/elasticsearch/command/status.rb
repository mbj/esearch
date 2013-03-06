module Elasticsearch
  class Command
    class Status < self
      include Composition.new(:subject)

      PRESENTER = Presenter::Status

      # Return result
      #
      # @return [Presenter]
      #
      # @api private
      #
      def result
        assert_success
        presenter.new(parsed_json)
      end

    private

      # Return response
      #
      # @return [Faraday::Response]
      #
      # @api private
      #
      def response
        connection.get(path)
      end
      memoize :response

      # Return connection
      #
      # @api private
      #
      def connection
        subject.connection
      end

      # Return path
      # 
      # @return [Path]
      #
      def path
        subject.path.join('_status').to_s
      end

    end
  end
end
