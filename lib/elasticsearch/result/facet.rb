module Elasticsearch
  class Result

    # Abstract base class for facets in results
    class Facet
      include Adamantium::Flat, AbstractType, Equalizer.new(:aspects)

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

      # Enumerate aspects
      #
      # @return [Enumerable<Aspect>]
      #
      # @api private
      #
      def aspects
        @data.fetch(facet_key).map do |item|
          aspect_class.new(item)
        end
      end
      memoize :aspects

    private

      # Return facet key
      #
      # @return [String]
      #
      # @api private
      #
      def facet_key
        self.class::FACET_KEY
      end

      # Return aspect class
      #
      # @return [Class]
      #
      # @api private
      #
      def aspect_class
        self.class::ASPECT_CLASS
      end

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

      # Facet that returns range counts
      class Range < self
        register 'range'

        ASPECT_CLASS = Aspect::Range
        FACET_KEY = 'ranges'.freeze
      end

      # Facet that returns term counts
      class Terms < self
        register 'terms'

        ASPECT_CLASS = Aspect::Term
        FACET_KEY = 'terms'.freeze
      end

    end
  end
end
