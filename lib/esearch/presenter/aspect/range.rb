module Esearch
  class Presenter
    class Aspect

      # Range aspect
      class Range < self

        # Return range start
        #
        # @return [Float]
        #   if present
        #
        # @return [nil]
        #   otherwise
        #
        # @api private
        #
        def from
          raw['from']
        end

        # Return range end
        #
        # @return [Float]
        #   if present
        #
        # @return [nil]
        #   otherwise
        #
        # @api private
        #
        def to
          raw['to']
        end

        # Return total count
        #
        # @return [Fixnum]
        #
        # @api private
        #
        expose_primitive(:total_count)

        # Return total
        #
        # @return [Float]
        #
        # @api private
        #
        expose_primitive(:total)

        # Return mean
        #
        # @return [Float]
        #
        # @api private
        #
        expose_primitive(:mean)

      end
    end
  end
end
