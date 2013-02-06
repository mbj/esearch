module Elasticsearch
  # Base class for request and response preprocessor
  class Preprocessor
    include Composition.new(:env)

    # Invoke preprocessor
    #
    # @param [Hash] env
    #
    # @api private
    #
    # @return [self]
    #
    def self.run(env)
      self.new(env).run

      self
    end

  protected

    # Return request method
    #
    # @return [Symbol]
    #
    # @api private
    #
    def method
      env.fetch(:method)
    end

    # Check if body should be converted from/to JSON
    #
    # Defaults to true.
    #
    # @return [true|false]
    #
    # @api private
    #
    def convert_json?
      options.fetch(:convert_json,true)
    end

    # Return request options
    #
    # @return [Hash]
    #
    # @api private
    #
    def options
      env.fetch(:request)
    end

    # Read request url
    #
    # @return [String]
    #
    # @api private
    #
    def url
      env.fetch(:url)
    end

    # Return request or response body
    #
    # @return [Object]
    #
    # @api private
    #
    def body
      env.fetch(:body)
    end

    # Return logger
    #
    # @return [Logger]
    #
    # @api private
    #
    def logger
      env[:logger]
    end

  end
end
