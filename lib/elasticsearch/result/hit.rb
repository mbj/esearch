module Elasticsearch
  class Result
    # Presenter for elasticsearch result hits
    class Hits
      include Adamantium::Flat, Enumerable

      # Return data
      #
      # @return [Hash]
      #
      # @api private
      #
      attr_reader :data

      # Enumerate contents
      #
      # @return [self]
      #   if block given
      #
      # @return [Enumerator<Hit>]
      #   otherwise
      #
      # @api private
      #
      def each(&block)
        return to_enum unless block_given?

        contents.each(&block)

        self
      end

      # Return contents enumerator
      #
      # @return [Enumerator<Hit>]
      #
      # @api private
      #
      def contents
        data.fetch('hits').map do |hit|
          Hit.new(hit)
        end
      end
      memoize :contents
      
      # Return total amount of hits
      #
      # @return [Fixnum]
      #
      # @api private
      #
      def total
        data.fetch('total')
      end

    private

      # Initialize ojbect
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
