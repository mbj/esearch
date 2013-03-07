module Elasticsearch
  class Command

    # Command to return cluster status
    class Status < self
      include Composition.new(:subject)

      PRESENTER = Presenter::Status

    private

      # Return request
      #
      # @return [Request]
      #
      # @api private
      #
      def request
        Request.get(subject_path.join('_status'))
      end

    end
  end
end
