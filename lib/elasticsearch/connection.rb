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

    [:put, :post, :get, :delete].each do |verb|
      define_method(verb) do |path, body = {}|
        logger.debug { "#{verb.to_s.upcase} #{path}: #{body.inspect}" }
        raw_connection.public_send(verb, path.to_s) do |request|
          request.body = MultiJson.dump(body)
        end
      end
    end

    def get_query(path, query)
      logger.debug { "GET #{path}? #{query.inspect}" }
      raw_connection.get(path, query)
    end

    def post_body_query(path, body, query)
      logger.debug { "POST #{path}? #{query.inspect} #{body.inspect}" }
      raw_connection.post(path.to_s, query) do |request|
        request.body = MultiJson.dump(body)
      end
    end
  end
end
