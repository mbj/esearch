module Elasticsearch
  class Command
    # Base class for commands on index
    class Index < self

      # Create index comand
      class Create < self
        include Composition.new(:subject, :settings)

        EXPECT_STATUS = [ 201 ].freeze
        PRESENTER = Presenter::Index::Create

      private

        # Return request
        #
        # @return [Request]
        #
        # @api private
        #
        def request
          Request.put(subject_path, settings)
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
          Request.delete(subject_path)
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
          Request.post(subject_path.join('_refresh'))
        end

      end
    end
  end
end
