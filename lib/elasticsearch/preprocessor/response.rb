module Elasticsearch
  class Preprocessor
    # Response preprocessor
    class Response < self
      # Preprocess response
      #
      # @return [self]
      #
      # @api private
      #
      def run
        log
        raise_on_error
        convert_json

        self
      end

    private

      # Raise if response is an error
      #
      # @return [self]
      #
      # @raise [RuntimeError]
      #
      # @api private
      #
      def raise_on_error
        unless expected_status_codes.include?(status)
          raise RemoteError, body
        end

        self
      end

      # Return expected status codes
      #
      # Defaults to 200.
      #
      # @return [Array<Integer>]
      #
      # @api private
      #
      def expected_status_codes
        [*options.fetch(:expect_status, 200)]
      end

      # Return response status
      #
      # @return [Fixnum]
      #
      # @api private
      #
      def status
        @env.fetch(:status)
      end

      # Load json request body
      #
      # @return [self]
      #
      # @api private
      #
      def convert_json
        return unless convert_json?

        unless json_content_type?
          raise ProtocolError, "Expected json content type but got: #{content_type.inspect}"
        end

        @env[:body] = MultiJson.load(body)

        self
      end

      # Check for json content type
      #
      # @return [true|false]
      #
      # @api private
      #
      def json_content_type?
        content_type == 'application/json; charset=UTF-8'
      end

      # Return response content type
      #
      # @return [String]
      #
      # @api private
      #
      def content_type
        response_headers['content-type']
      end

      # Return response headers
      #
      # @return [Hash]
      #
      # @api private
      #
      def response_headers
        @env.fetch(:response_headers)
      end

      # Log this response
      #
      # @return [undefined]
      #
      # @api private
      #
      def log
        logger.debug("#{status}")
      end
    end
  end
end
