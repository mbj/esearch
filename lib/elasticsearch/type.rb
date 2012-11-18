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

    # Batch create documents
    #
    # @param [Enumerable<Hash>] documents
    #
    # @return [self]
    #
    # @api private
    #
    def bulk(bulk)
      index.bulk(bulk, name)
      self
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
      index.connection.connection.post("#{index.name}/#{name}/#{id}?op_type=create") do |request|
        request.options[:expect_status]=201
        request.options[:convert_json]=201
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
      index.connection.connection.post("#{index.name}/#{name}/#{id}?op_type=index") do |request|
        request.options[:expect_status]=200
        request.options[:convert_json]=200
        request.body = document
      end

      self
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
      index.connection.connection.delete("#{index.name}/#{name}/#{id}") do |request|
        request.options[:expect_status]=200
        request.options[:convert_json]=200
      end

      self
    end

  private

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
