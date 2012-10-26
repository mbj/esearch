module Elasticsearch
  class Hits
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def total
      data.fetch('total')
    end
  end
end
