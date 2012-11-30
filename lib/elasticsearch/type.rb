module Elasticsearch
  # Driver for specific elasticsearch type
  class Type
    include Adamantium::Flat, Equalizer.new(:index, :name)

    # Return index
    #
    # @return [Index]
    #
    # @api private
    #
    attr_reader :index
    
    # Return name
    #
    # @return [String]
    #
    # @api private
    #
    attr_reader :name

    # Get document
    #
    # @param [String] id
    #
    # @return [Hash]
    #   if present
    #
    # @return [nil]
    #   otherwise
    #
    # @api private
    #
    def get(id)
      response = pure_connection.get("#{index.name}/#{name}/#{id}") do |request|
        options = request.options
        options[:expect_status] = [200, 404]
        options[:convert_json] = true
      end

      if response.status == 200
        return response.body
      end
    end

    # Create document 
    #
    # @param [String] id
    # @param [Hash] document
    #
    # @return [self]
    #
    # @api private
    #
    def create(id, document)
      index = self.index

      pure_connection.post("#{index.name}/#{name}/#{id}?op_type=create") do |request|
        options = request.options
        options[:expect_status]=201
        options[:convert_json]=201
        request.body = document
      end

      self
    end

    # Update document
    #
    # @param [String] id
    # @param [Hash] document
    #
    # @return [self]
    #
    # @api private
    #
    def update(id, document)
      index = self.index

      pure_connection.post("#{index.name}/#{name}/#{id}?op_type=index") do |request|
        options = request.options
        options[:expect_status]=200
        options[:convert_json]=200
        request.body = document
      end

      self
    end

    # Return result from query
    #
    # @param [Result] query
    #   the query in elasticsearch format as a hash
    #
    # @api private
    #
    # @return [Result]
    #   returns a result instance wrapping the decoded json body
    #
    def read(query)
      connection.read("#{index.name}/#{name}", query)
    end

    # Delete document
    #
    # @param [String] id
    # @param [Hash] document
    #
    # @return [self]
    #
    # @api private
    #
    def delete(id)
      pure_connection.delete("#{index.name}/#{name}/#{id}") do |request|
        options = request.options
        options[:expect_status]=200
        options[:convert_json]=200
      end

      self
    end

  private

    # Return pure connection
    #
    # TODO: This will be resovled when we have operations, it is a misdesign
    #
    # @return [Faraday::Connection]
    #
    # @api private
    #
    def pure_connection
      index.connection.connection
    end

    # Initialize object
    #
    # @param [Adapter::Elasticsearch::Index] index
    # @param [String] name
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(index, name)
      @index, @name = index, name
    end

  end
end
