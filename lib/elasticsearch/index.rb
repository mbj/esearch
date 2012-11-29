module Elasticsearch
  # Driver for specific index
  class Index
    include Adamantium::Flat, Equalizer.new(:name, :connection)

    # Return name of index
    #
    # @return [String]
    #
    # @api private
    #
    attr_reader :name

    # Return connection
    #
    # @return [Connection]
    #
    # @api private
    #
    attr_reader :connection

    # Refresh index
    #
    # @api private
    #
    # @return [self]
    #
    def refresh
      connection.refresh(name)
      self
    end

    # Drop index
    #
    # @return [self]
    #
    # @api private
    #
    def drop
      connection.drop(name)
      self
    end

    # Wait for index presence
    #
    # @param [Hash] options
    #
    # @return [self]
    #
    # @api private
    #
    def wait(options={})
      connection.wait(name, options)
      self
    end

    # Test if index does exist
    #
    # @return [true]
    #   if index does exist
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def exist?
      connection.exist?(name)
    end

    # Refresh index
    #
    # @return [self]
    #
    # @api private
    #
    def refresh
      connection.refresh(name)
      self
    end

    # Setup index
    #
    # @param [Hash] settings
    #
    # @return [self]
    #
    # @api private
    #
    def setup(settings = {})
      connection.setup(name, settings)
      self
    end

    # Return tuples from query
    #
    # @param [String] path
    #   the elasticsearch path to query most likely a string with the index name
    #
    # @param [Hash] query
    #   the query in elasticsearch format as a hash
    #
    # @api private
    #
    # @return [Result]
    #   returns a result instance wrapping the decoded json body
    #
    def read(query)
      connection.read(name, query)
    end

    # Return type for index
    #
    # @param [String] name
    #
    # @return [Type]
    #
    # @api private
    #
    def type(name)
      Type.new(self, name)
    end

  private

    # Initialize object
    #
    # @param [Connection] connection
    # @param [String] name
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(connection, name)
      @connection, @name = connection, name
    end
  end
end
