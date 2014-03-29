module Esearch
  class Command
    # Base class for commands on index
    class Index < self

      # Create index comand
      class Create < self
        include Concord.new(:context, :settings)

        EXPECT_STATUS = [201].freeze
        PRESENTER = Presenter::Index::Create

      private

        # Return request
        #
        # @return [Request]
        #
        # @api private
        #
        def request
          Request.put(context_path, settings)
        end

      end

      # Delete index comand
      class Delete < self

        PRESENTER = Presenter::Index::Delete

      private

        # Return request
        #
        # @return [Request]
        #
        # @api private
        #
        def request
          Request.delete(context_path)
        end

      end

      # Refresh index command
      class Refresh < self

        PRESENTER = Presenter::Index::Refresh

      private

        # Return request
        #
        # @return [Request]
        #
        # @api private
        #
        def request
          Request.post(context_path.join('_refresh'))
        end

      end # Delete
    end # Index
  end # Command
end # Esearch
