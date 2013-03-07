module Elasticsearch
  class Command
    # Search command
    class Search < self
      include Composition.new(:subject, :query)

      PRESENTER = Presenter::Search

    private

      # Return request
      #
      # @return [Request]
      #
      # @api private
      #
      def request
        Request.get(subject_path.join('_search'), query)
      end

    end
  end
end

