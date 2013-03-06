module Elasticsearch
  class Presenter

    # Presenter for elasticsearch result hits
    class Hits < self
      include Enumerable

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

        raw_hits.map do |hit|
          yield Hit.new(hit)
        end

        self
      end

      # Return amount of hits in this request
      #
      # @return [Fixnum]
      #
      # @api private
      #
      def size
        raw_hits.size
      end
      
      # Return total amount of hits in the query
      #
      # @return [Fixnum]
      #
      # @api private
      #
      expose_primitive('total')

    private

      # Return raw hits
      #
      # @return [Array]
      #
      # @api private
      #
      def raw_hits
        raw.fetch('hits')
      end

    end
  end
end

