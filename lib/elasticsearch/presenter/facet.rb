module Elasticsearch
  class Presenter

    # Base class for facets in results
    class Facet < self

      TYPE_KEY = '_type'.freeze

      # Build facet from raw
      #
      # @param [Hash] raw
      #
      # @return [Facet]
      #
      # @api private
      #
      def self.build(raw)
        type = raw.fetch(TYPE_KEY)
        get(type).new(raw)
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
        REGISTRY.fetch(type) do
          raise "Facet with type #{type.inspect} is not known"
        end
      end
      private_class_method :get

      REGISTRY = {}

      # Register type
      #
      # @param [String] type
      #
      # @return [undefined]
      #
      # @api private
      #
      def self.register(type)
        REGISTRY[type]=self
      end
      private_class_method :register

      # Enumerate aspects
      #
      # @return [Enumerable<Aspect>]
      #
      # @api private
      #
      def aspects
        raw.fetch(facet_key).map do |item|
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
