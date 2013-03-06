module Elasticsearch
  class Presenter

    # Abstract base class of an aspect of a facet
    class Aspect < self

      # Return count of occurences of aspect in facet
      #
      # @return [Fixnum]
      #
      # @api private
      #
      expose_primitive(:count)

    end
  end
end
