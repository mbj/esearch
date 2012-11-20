module Elasticsearch
  class Result
    # Presenter for elasticsearch result hits
    class Hits
      include Adamantium::Flat, Enumerable

      attr_reader :data
      private :data

      def initialize(data)
        @data = data
      end

      def each(&block)
        return to_enum unless block_given?

        contents.each(&block)

        self
      end

      def contents
        data.fetch('hits').map do |hit|
          Hit.new(hit)
        end
      end
      memoize :contents
      
      def total
        data.fetch('total')
      end
    end
  end
end
