module Elasticsearch
  class Result
    # Presenter for an hit
    class Hit
      include Adamantium::Flat, Equalizer.new(:document)
  
      # Return presented document
      #
      # @return [Hash]
      #
      # @api private
      #
      attr_reader :document
  
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

    private
  
      # Initialize object
      #
      # @param [Hash] document
      #
      # @return [self]
      #
      # @api private
      #
      def initialize(document)
        @document = document
      end

    end
  end
end
