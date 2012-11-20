module Elasticsearch
  class Result

    # Abstract base class for facets in results
    class Facet
      include Adamantium::Flat, AbstractClass, Equalizer.new(:aspects)

      # Build facet from data
      #
      # @param [Hash] data
      #
      # @return [Facet]
      #
      # @api private
      #
      def self.build(data)
        type = data.fetch('_type')
        get(type).new(data)
      end

      # Get class for type
      #
      # @param [String] type
      #
      # @return [Class:Facet]
      #
      # @api private
      #
      def self.get(type)
        registry.fetch(type) do
          raise "Facet with type #{type.inspect} is not known"
        end
      end

      # Return registry
      #
      # @api private
      #
      # @return [Hash]
      #
      def self.registry
        @@registry ||= {}
      end
      private_class_method :registry

      # Register type
      #
      # @param [String] type
      #
      # @return [undefined]
      #
      # @api private
      #
      def self.register(type)
        registry[type]=self
      end
      private_class_method :register

      # Return aspects
      #
      # @return [Enumerable<Aspect]
      #
      # @api private
      #
      abstract_method :aspects

      # Return size of aspects
      #
      # @return [Fixnum]
      #
      # @api private
      #
      def size
        aspects.size
      end

    private

      # Initialize object
      #
      # @param [Hash] data
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(data)
        @data = data
      end

    end
  end
end
