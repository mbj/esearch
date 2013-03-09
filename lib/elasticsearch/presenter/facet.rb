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

      # Enumerate aspects
      #
      # @return [Enumerable<Aspect>]
      #
      # @api private
      #
      def aspects
        util = self.class
        raw.fetch(util::FACET_KEY).map do |item|
          util::ASPECT_CLASS.new(item)
        end
      end
      memoize :aspects

    private

      # Facet that returns range counts
      class Range < self
        ASPECT_CLASS = Aspect::Range
        FACET_KEY = 'ranges'.freeze
      end

      # Facet that returns term counts
      class Terms < self
        ASPECT_CLASS = Aspect::Term
        FACET_KEY = 'terms'.freeze
      end

      REGISTRY = {
        'range' => Range,
        'terms' => Terms
      }.freeze

    end
  end
end
