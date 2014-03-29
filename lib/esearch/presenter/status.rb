module Esearch
  class Presenter

    # Status presenter base class
    class Status < self

      # Status of an elasticsearch index
      class Index < Presenter

        expose_primitive('name')

      end # Index

      expose_tagged_collection('indices', Status::Index)

    end # Status
  end # Presenter
end # Esearch
