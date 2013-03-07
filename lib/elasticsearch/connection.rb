module Elasticsearch
  # Connection to an elasticsearch cluster
  class Connection
    include Adamantium::Flat, Concord.new(:raw_connection, :logger)

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


    # Run request 
    #
    # @param [Command::Request] request
    #
    # @return [Faraday::Request]
    #
    # @api private
    #
    def run(request)
      util = logger
      util.debug { request.log_string }
      response = request.run(raw_connection)
      util.debug { response.status.to_s }
      response
    end

  end
end
