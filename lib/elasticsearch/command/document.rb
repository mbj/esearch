module Elasticsearch
  class Command

    # Base class for commands on documents
    class Document < self

      # Document index command
      class Index < self
        include Composition.new(:context, :document, :options)

        EXPECTED_STATI = [ 200, 201 ]
        PRESENTER = Presenter::Document::Operation::Index

        FORCE_OPTIONS = {}

      private

        # Return request
        #
        # @return [Request]
        #
        # @api private
        #
        def request
          Request.post(context_path, document, effective_options)
        end

        # Return effective options
        #
        # @return [Hash]
        #
        # @api private
        #
        def effective_options
          options.merge(self.class::FORCE_OPTIONS)
        end

        # Document index update command
        class Update < self
          EXPECTED_STATI = [ 200 ]
          FORCE_OPTIONS = { :op_type => :update }.freeze
        end

        # Document index create command
        class Create < self
          EXPECTED_STATI = [ 201 ]
          FORCE_OPTIONS = { :op_type => :create }.freeze
        end
      end

      # Present get document command result
      class Get < self
        
        PRESENTER = Presenter::Document::Get

      private

        # Return request
        #
        # @return [Request]
        #
        # @api private
        #
        def request
          Request.get(context_path)
        end

      end

      # Present delete document command result
      class Delete < self

        PRESENTER = Presenter::Document::Operation::Delete

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

    end
  end
end
