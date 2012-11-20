module Elasticsearch
  class Result
    class Facet
      # Abstract base class of an aspect of a facet
      class Aspect
        include Adamantium::Flat, AbstractClass

        # Return count of occurences of aspect in facet
        #
        # @return [Fixnum]
        #
        # @api private
        #
        def count
          @data.fetch('count')
        end

      private

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
      end

      class Aspect

        class Range < self
          
          # Return range start 
          #
          # @return [Float]
          #
          # @api private
          #
          def from
            @data.fetch('from', nil)
          end

          # Return range end 
          #
          # @return [Float]
          #
          # @api private
          #
          def to
            @data.fetch('to', nil)
          end

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

      class Aspect

        # Aspect of a term facet
        #
        # @return [Object]
        #
        # @api private
        #
        class Term < self

          # Return value of aspect
          #
          # @return [String]
          #
          # @api private
          #
          def value
            @data.fetch('term')
          end
        end
      end
    end
  end
end
