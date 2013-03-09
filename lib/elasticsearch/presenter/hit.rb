module Elasticsearch
  class Presenter

    # Presenter for an hit
    class Hit < self
  
      # Return source field if present
      #
      # @return [Hash] 
      #   if present
      #
      # @return [nil]
      #   otherwise
      #
      # @api private
      #
      def source
        raw['_source']
      end

      # Return index name
      #
      # @return [String]
      #
      # @api private
      #
      expose_primitive(:_index, :index_name)

      # Return type name
      #
      # @return [Type]
      #
      # @api private
      #
      expose_primitive(:_type, :type_name)

      # Return id
      #
      # @return [String]
      #
      # @api private
      #
      expose_primitive(:_id, :id)

      # Return score
      #
      # @return [Float]
      #
      # @api private
      #
      expose_primitive(:_score, :score)

    end
  end
end

