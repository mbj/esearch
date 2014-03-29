# encoding: UTF-8

module Esearch
  class Presenter
    class Aspect

      # Aspect of a term facet
      class Term < self

        # Return value of aspect
        #
        # @return [String]
        #
        # @api private
        #
        expose_primitive(:term, :value)

      end # Term
    end # Aspect
  end # Presenter
end # Esearch
