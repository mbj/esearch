module Elasticsearch
  # Handler for document
  class Document
    include Composition.new(:type, :id)
  end
end
