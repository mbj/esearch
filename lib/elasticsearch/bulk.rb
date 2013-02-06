module Elasticsearch
  # Bulk operation
  class Bulk
    include Adamantium::Flat, Composition.new(:operations)

    # Return body for bulk operation
    # 
    # @return [String]
    #
    # @api private
    #
    def body
      operations.map do |operation|
        operation.bulk_operation
      end.join("\n")
    end
    memoize :body

  end
end
