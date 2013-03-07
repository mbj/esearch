module Elasticsearch

  # Request used to interface elasticsearch
  class Request
    include Adamantium, Equalizer.new(:verb, :path, :body, :params)

    EMPTY_HASH = {}.freeze

    # Return http verb
    #
    # @return [Symbol]
    #
    # @api private
    #
    attr_reader :verb

    # Return path
    #
    # @return [String]
    #
    # @api private
    #
    attr_reader :path

    # Return body
    #
    # @return [Hash]
    #
    # @api private
    #
    attr_reader :body

    # Return params
    #
    # @return [Hash]
    #
    # @api private
    #
    attr_reader :params

    # Initialize object
    #
    # @param [Symbol] verb
    # @param [String] path
    # @param [Hash] body
    # @param [Hash] params
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(verb, path, body = EMPTY_HASH, params = EMPTY_HASH)
      @verb, @path, @body, @params = verb, path.to_s, body, params
    end

    # Return log string
    #
    # @return [String]
    #
    # @api private
    #
    def log_string
      "#{verb.upcase} #{path} : #{params} : #{body}"
    end
    memoize :log_string

    # Run request on connection
    #
    # @param [Faraday::Connection]
    #
    # @return [Faraday::Response]
    #
    # @api private
    #
    def run(connection)
      connection.public_send(verb, path) do |request|
        request.headers[:content_type]=Command::JSON_CONTENT_TYPE
        request.body = MultiJson.dump(body)
      end
    end

    [:head, :get, :post, :put, :delete].each do |verb|
      define_singleton_method(verb) do |*args|
        new(verb, *args)
      end
    end

  end
end
