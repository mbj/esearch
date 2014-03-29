module Esearch
  class Presenter

    # Base class for index operation result presenters
    class Index < self

      # Create operation presenter
      class Create < self
        expose_primitive :ok, :ok?
      end # Create

      # Delete operation presenter
      class Delete < self
        expose_primitive :ok, :ok?
      end # Delete

      # Refresh operation presenter
      class Refresh < self
      end # Referesh

    end # Index
  end # Presenter
end # Esearch
