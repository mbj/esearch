module Elasticsearch
   class Facet

    # Abstract base class for facet types
    class Type
      include Adamantium, AbstractClass
      extend DescendantsTracker

      def self.field_name
        self::FIELD_NAME
      end

      def self.type_name
        self::NAME
      end

      def self.cache
        @cache ||= {}
      end

      def self.get(name)
        cache.fetch(name) do
          type = find(name)

          unless type
            raise("Facet type with field: #{name.inspect} does not exist")
          end

          cache[name]= type
        end
      end

      def self.find(name)
        descendants.detect { |type| type.type_name == name }
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
      # Range facet
      class Range < self
        include Equalizer.new(:from, :to, :count, :mean)

        NAME  = 'range'.freeze
        FIELD_NAME = 'ranges'.freeze

        def from
          @document.fetch('from', nil)
        end

        def to
          @document.fetch('to', nil)
        end

        def count
          @document.fetch('count')
        end

        def mean
          @document.fetch('mean')
        end
      end

      # Terms facet
      class Terms < self
        include Equalizer.new(:term, :count)

        NAME = FIELD_NAME = 'terms'.freeze

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
