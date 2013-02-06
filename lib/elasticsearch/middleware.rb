module Elasticsearch

  # Faraday middleware for elasticsearch http connections
  class Middleware
    include Adamantium::Flat, Composition.new(:app, :logger)

    # Middleware call from faraday
    #
    # @param [Hash] env
    #
    # @return [self]
    #
    # @api private
    #
    def call(env)
      env[:logger] = @logger

      Preprocessor::Request.run(env)

      @app.call(env).on_complete do
        Preprocessor::Response.run(env)
      end
    end

  end
end
