module Elasticsearch
  class Preprocessor
    # Request preprocessor
    class Request < self

      # Do preprocessing on request
      #
      # @return [self]
      #
      # @api private
      #
      def run
        convert_json
        log

        self
      end

    private

      # Convert body to json
      #
      # @return [self]
      #
      # @api private
      #
      def convert_json
        return unless convert_json?

        body = self.body

        @env[:body] = MultiJson.dump(body) if body

        self
      end

      # Log this request
      #
      # @return [self]
      #
      # @api private
      #
      def log
        logger.debug("#{method.upcase} #{url} #{body}")

        self
      end
    end
  end
end
