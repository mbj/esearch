module Elasticsearch
  class Result
    class Aspect

      # Range aspect
      class Range < self
        
        # Return range start 
        #
        # @return [Float]
        #
        # @api private
        #
        def from
          @data['from']
        end
        memoize :from

        # Return range end 
        #
        # @return [Float]
        #
        # @api private
        #
        def to
          @data['to']
        end
        memoize :to

        # Return total count
        #
        # @return [Fixnum]
        #
        # @api private
        #
        def total_count
          @data.fetch('total_count')
        end

        # Return total 
        #
        # @return [Float]
        #
        # @api private
        #
        def total
          @data.fetch('total')
        end

        # Return mean 
        #
        # @return [Float]
        #
        # @api private
        #
        def mean
          @data.fetch('mean')
        end
      end

    end
  end
end
