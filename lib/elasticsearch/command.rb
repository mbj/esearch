module Elasticsearch
  # Abstract base class for elasticsearch commands
  class Command 
    include Adamantium::Flat, AbstractType

    def self.run(*args)
      new(*args).result
    end

    # Return result of request
    #
    # @return [self]
    #
    # @api private
    #
    def result
      assert_success
      self
    end


  private

    JSON_CONTENT_TYPE = 'application/json; charset=UTF-8'.freeze

    # Test for json content type
    #
    # @return [true]
    #   if content type is json
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def json_content_type?
      content_type.eql?(JSON_CONTENT_TYPE)
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

    # Test for success
    #
    # @return [undefined]
    #
    # @api private
    #
    def assert_success
      unless response.status == 200
        raise_remote_error
      end
    end

    # Return response headers
    #
    # @return [Hash]
    #
    # @api private
    #
    def response_headers
      response.headers
    end

    def raise_remote_error
      message=
        if json_content_type?
          parsed_json.inspect
        else
          response.body
        end
      raise RemoteError, message
    end

    def parsed_json
      unless json_content_type?
        raise ProtocolError, "Expected json body, but got: #{content_type}"
      end
      MultiJson.load(response.body)
    end
    memoize :parsed_json

  private

    # Return response
    #
    # @return [Faraday::Response]
    #
    # @api private
    #
    abstract_method :response
  end
end
