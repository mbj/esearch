module Elasticsearch
  class Presenter

    # Status presenter base class
    class Status < self

      # Status of an elasticsearch index
      class Index < Presenter

        expose_primitive('name')

      end

      expose_tagged_collection('indices', Status::Index)

    end
  end
end
