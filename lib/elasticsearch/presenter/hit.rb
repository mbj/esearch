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
      def index_name
        raw.fetch('_index')
      end

      # Return type name
      #
      # @return [Type]
      #
      # @api private
      #
      def type_name
        raw.fetch('_type')
      end

      # Return id
      #
      # @return [String]
      #
      # @api private
      #
      def id
        raw.fetch('_id')
      end

      # Return score
      #
      # @return [Float]
      #
      # @api private
      #
      def score
        raw.fetch('_score')
      end

    end
  end
end

