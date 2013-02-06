module Elasticsearch
  # Driver for specific elasticsearch type
  class Type
    include Adamantium::Flat, Composition.new(:index, :name)

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
      perform_document_action(id, document, :create, 201)
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
      perform_document_action(id, document, :index, 200)
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
      index.read(query, name)
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

    # Perform document action
    #
    # @param [String] id
    # @param [Hash] document
    # @param [Symbol] action
    # @param [Fixnum] status
    #
    # @return [undefined]
    #
    # @api private
    #
    def perform_document_action(id, document, action, status)
      pure_connection.post("#{index.name}/#{name}/#{id}?op_type=#{action}") do |request|
        options = request.options
        options[:expect_status]=status
        options[:convert_json]=true
        request.body = document
      end
    end

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

  end
end
