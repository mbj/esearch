module Elasticsearch
  class Result
    # Presenter for elasticsearch result hits
    class Hits
      include Adamantium::Flat, Enumerable, Composition.new(:data)

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
        raw_hits.map do |hit|
          Hit.new(hit)
        end
      end
      memoize :contents

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
      def total
        data.fetch('total')
      end

    private

      # Return raw hits
      #
      # @return [Array]
      #
      # @api private
      #
      def raw_hits
        data.fetch('hits')
      end

    end
  end
end
