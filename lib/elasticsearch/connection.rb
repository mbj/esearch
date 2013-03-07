module Elasticsearch
  # Connection to an elasticsearch cluster
  class Connection
    include Adamantium::Flat, Composition.new(:raw_connection, :logger)

    # Return connection
    #
    # @param [String] uri
    #
    # @return [Connection]
    #
    # @api private
    #
    def self.build(uri, logger = NullLogger.instance)
      new(Faraday.new(uri), logger)
    end

    [:put, :post, :get, :delete, :head].each do |verb|
      define_method(verb) do |path, *args|
        http_request(verb, path, *args)
      end
    end

  private

    # Run http request
    #
    # @param [Symbol] verb
    # @param [#to_s] path
    # @param [Hash] body
    # @param [Hash] query
    #
    # @return [Faraday::Response]
    #
    # @api private
    #
    def http_request(verb, path, body = {}, query = {})
      logger.debug { "#{verb.to_s.upcase} #{path} : #{query.inspect} : #{body.inspect}" }
      response = raw_connection.public_send(verb, path.to_s) do |request|
        request.body = MultiJson.dump(body)
      end
      logger.debug { response.status.to_s }
      response
    end
  end
end
