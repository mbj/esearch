module Elasticsearch
  class Command
    # Command to check existance of objects
    class Exist < self

      EXPECTED_STATI = [ 200, 404 ].freeze

      # Return result
      #
      # @return [true]
      #   if object exists
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      def result
        assert_success
        response.status == 200
      end

    private

      # Return request
      #
      # @return [Request]
      #
      # @api private
      #
      def request
        Request.head(subject_path)
      end

    end
  end
end
