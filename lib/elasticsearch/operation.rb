module Elasticsearch
  class Operation
    include Adamantium::Flat

    class Create < self
      def initialize(document)
        @document = document
      end
    end

    class Update < self
      def initialize(document)
        @document = document
      end
    end
  end
end
