module Elasticsearch

  # Faraday middleware for elasticsearch http connections
  class Middleware
    include Adamantium::Flat

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

  private

    # Initialize middleware
    #
    # @param [#call] app
    # @param [Logger] logger
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(app, logger=NullLogger)
      @app, @logger = app, logger
    end
  end

end
