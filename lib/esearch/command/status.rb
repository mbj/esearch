module Esearch
  class Command

    # Command to return cluster status
    class Status < self
      include Concord.new(:context)

      PRESENTER = Presenter::Status

    private

      # Return request
      #
      # @return [Request]
      #
      # @api private
      #
      def request
        Request.get(context_path.join('_status'))
      end

    end # Status
  end # Command
end # Esearch
