module Esearch
  class Command
    # Search command
    class Search < self
      include Concord.new(:context, :query)

      PRESENTER = Presenter::Search

    private

      # Return request
      #
      # @return [Request]
      #
      # @api private
      #
      def request
        Request.get(context_path.join('_search'), query)
      end

    end # Search
  end # Command
end # Esearch
