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
      define_method(verb) do |path, body = {}, query = {}|
        logger.debug { "#{verb.to_s.upcase} #{path} : #{query.inspect} : #{body.inspect}" }
        raw_connection.public_send(verb, path.to_s) do |request|
          request.body = MultiJson.dump(body)
        end
      end
    end
  end
end
