module Elasticsearch
  # Bulk operation
  class Bulk
    include Adamantium::Flat, Equalizer.new(:operations)

    # Return operations
    #
    # @return [Enumerable<Operation>]
    #
    # @api private
    #
    attr_reader :operations

    # Return body for bulk operation
    # 
    # @return [String]
    #
    # @api private
    #
    def body
      operations.map do |operation|
        [
          operation.bulk_header,
          operation.bulk_body
        ].join("\n")
      end.join("\n")
    end
    memoize :body

  private

    # Initialize object
    #
    # @param [Enumerable<Operation>] operations
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(operations)
      @operations = operations
    end
  end
end
