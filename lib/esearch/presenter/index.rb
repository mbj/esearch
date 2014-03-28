module Esearch
  class Presenter

    # Base class for index operation result presenters
    class Index < self

      # Create operation presenter
      class Create < self
        expose_primitive :ok, :ok?
      end

      # Delete operation presenter
      class Delete < self
        expose_primitive :ok, :ok?
      end

      # Refresh operation presenter
      class Refresh < self
      end

    end
  end
end
