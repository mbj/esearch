module Elasticsearch
  class Command
    # Read command
    class Read < self
      include Composition.new(:subject, :query)

      # Return result
      #
      # @return [Presenter::Result]
      #
      # @api private
      #
      def result
        assert_success
        Presenter::Result.new(parsed_json)
      end

    private

      # Return response
      #
      # @return [Faraday::Response]
      #
      # @api private
      #
      def response
        connection.get(subject_path.join('_search'), query)
      end
      memoize :response

    end
  end
end

