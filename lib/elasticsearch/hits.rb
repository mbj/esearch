module Elasticsearch
  class Hits
    def initialize(data)
      @data = data
    end

    def total
      data.fetch('total')
    end
  end
end
