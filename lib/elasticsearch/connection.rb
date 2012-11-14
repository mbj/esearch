module Elasticsearch
  # Connection to elasticsearch
  class Connection
    include Adamantium::Flat

    # Return index with name
    #
    # @param [String] name
    #
    # @return [Index]
    #
    # @api private
    #
    def index(name)
      Index.new(self, name)
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
    def read(path, query)
      path = "#{path}/_search"

      response = @connection.get(path) do |request|
        request.body = query
      end

      Result.new(response.body)
    end

    # Drop index if exist
    #
    # @param [String] name
    #   the name of the index to drop
    #
    # @return [self]
    #
    # @api private
    #
    def drop(name)
      if exist?(name)
        connection.delete(name)
      end

      self
    end

    # Wait for index to be fully initialized
    #
    # @param [String] name
    #   the name of the index to wait for
    #
    # @param [Hash] options
    #   the options for this wait operation.
    #
    # @return [self]
    #
    # @api private
    #
    def wait(name, options={})
      defaults = {
        :wait_for_status => :green,
        :timeout => 60,
        :level => :index
      }

      connection.get("_cluster/health/#{name}", defaults.merge(options))

      self
    end

    # Check if index does exist
    #
    # @return [true]
    #   returns true when index does exist
    #
    # @return [false]
    #   returns false when index does NOT exist
    #
    # @api private
    #
    def exist?(index)
      connection.head(index) do |request|
        request.options.merge!(:convert_json => false, :expect_status => [200, 404])
      end.status == 200
    end

    # Perform bulk operation
    #
    # @param [Bulk]
    # @param [Path]
    #
    def bulk(bulk, path = nil)
      connection.post("#{path}/_bulk") do |request|
        p bulk
        request.body = bulk.body
      end
    end

    # Trigger refresh on index
    #
    # This syncs the latest write operations.
    # Read docs before use.
    #
    # @param [String] index
    #   the index to refresh if empty refreshes all indexes
    #
    # @return [self]
    #
    # @api private
    #
    def refresh(index=nil)
      path = "#{index}/_refresh"

      connection.post(path)

      self
    end

    # Setup index
    #
    # @param [String] index
    #   the name of the index to crate
    #
    # @param [Hash] settings
    #   the settings used when creating the index
    #
    # @return [self]
    #
    # @api private
    #
    def setup(index, settings=DEFAULT_INDEX_SETTINGS)
      connection.put("#{index}") do |request|
        request.body = settings
      end

      self
    end

    # Return connection
    #
    # @return [Faraday::Connection]
    #
    # @api private
    #
    def connection
      @connection
    end

    # Return slice length
    #
    # @return [Fixnum]
    #
    # @api private
    #
    def slice_size
      @options.fetch(:slice_size, 100)
    end

  private

    DEFAULT_INDEX_SETTINGS = {
      'settings' => {
        'number_of_shards' => 1,
        'number_of_replicas' => 0
      }
    }.freeze

    # Initialize connection
    #
    # @param [String] uri
    #   the uri of the elasticsearch node to connect
    #
    # @return [undefined]
    #
    # @api private
    #
    #
    def initialize(uri, options={})
      @uri     = uri
      @options = options
      @connection = Faraday.new(@uri) do |builder|
        adapter = [*@options.fetch(:adapter, :net_http)]
        logger  = @options.fetch(:logger, NullLogger)
        builder.use(Middleware, logger)
        builder.adapter(*adapter)
      end
    end
  end
end
