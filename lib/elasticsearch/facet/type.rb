module Elasticsearch
   class Facet

    # Abstract base class for facet types
    class Type
      include Adamantium, AbstractClass
      extend DescendantsTracker

      def self.field_name
        self::FIELD_NAME
      end

      def self.cache
        @cache ||= {}
      end

      def self.get(name)
        cache[name] ||= descendants.detect { |type| type.field_name == name } || raise
      end

    private

      # Initialize object
      #
      # @param [Hash] document
      #
      # @api private
      #
      def initialize(document)
        @document = document
      end
    end

    class Type
      # Term facet
      class Terms < self
        include Equalizer.new(:term, :count)

        FIELD_NAME = 'terms'.freeze

        def term
          @document.fetch('term')
        end
        memoize :term

        def count
          @document.fetch('count')
        end
        memoize :term
      end
    end
   end
end
