module Elasticsearch
  class Hit
    include Adamantium::Flat

    attr_reader :document
    private :document

    def initialize(document)
      @document = document
    end

    def source
      document['_source']
    end
  end
end
