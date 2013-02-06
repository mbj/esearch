module Elasticsearch
  class Result
    # Presenter for an hit
    class Hit
      include Adamantium::Flat, Composition.new(:document)
  
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
        document['_source']
      end

    end
  end
end
