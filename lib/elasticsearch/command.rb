module Elasticsearch
  # Abstract base class for elasticsearch commands
  class Command 
    include Adamantium::Flat, AbstractType, Concord.new(:context)

    EXPECTED_STATI    = [ 200 ].freeze
    JSON_CONTENT_TYPE = 'application/json; charset=UTF-8'.freeze

    # Run command
    #
    # @return [Object]
    #
    # @api private
    #
    def self.run(*args)
      new(*args).result
    end

    # Return result of request
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

    # Return presenter
    #
    # @return [Class:Presenter]
    #
    # @api private
    #
    def presenter
      self.class::PRESENTER
    end

    # Return connection
    #
    # @return [Faraday::Connection]
    #
    # @api private
    #
    def connection
      context.connection
    end

    # Return context path
    #
    # @return [Pathname]
    #
    # @api private
    #
    def context_path
      context.path
    end

    # Return response content type
    #
    # @return [String]
    #
    # @api private
    #
    def content_type
      response.headers['content-type']
    end

    # Return expected response stati
    #
    # @return [Enumerable<Fixnum>]
    # 
    # @api private
    #
    def expected_response_stati
      self.class::EXPECTED_STATI
    end

    # Test for success
    #
    # @return [undefined]
    #
    # @api private
    #
    def assert_success
      unless expected_response_stati.include?(response.status)
        raise_status_error
      end
    end

    # Raise remote status error
    #
    # @return [undefined]
    #
    # @api private
    #
    def raise_status_error
      raise "expected response stati: #{expected_response_stati.inspect} but got: #{response.status}, remote message: #{remote_message}"
    end

    # Return remote message
    #
    # @return [String]
    #
    # @api private
    #
    def remote_message
      if json_content_type?
        parsed_json.inspect
      else
        response.body
      end
    end

    # Return parsed json
    #
    # @return [Hash]
    #
    # @api private
    #
    def parsed_json
      unless json_content_type?
        raise ProtocolError, "Expected json content_type, but got: #{content_type.inspect}"
      end
      MultiJson.load(response.body)
    end
    memoize :parsed_json

    # Return response
    #
    # @return [Faraday::Response]
    #
    # @api private
    #
    def response
      connection.run(request)
    end
    memoize :response

  end
end
