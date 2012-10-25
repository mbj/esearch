module Elasticsearch

  # A null logger that supports a subset of the ruby logger api
  module NullLogger
    # Log debug message
    #
    # @return [self]
    #
    # @api private
    #
    def self.debug(message)
      self
    end

    # Log info message
    #
    # @return [self]
    #
    # @api private
    #
    def self.info(message)
      self
    end

    # Log warning message
    #
    # @return [self]
    #
    # @api private
    #
    def self.warn(message)
      self
    end

    # Log error message
    #
    # @return [self]
    #
    # @api private
    #
    def self.error(message)
      self
    end
  end

end
