module Elasticsearch
  class Command

    # Base class for commands on documents
    class Document < self

      # Document index command
      class Index < self
        include Composition.new(:subject, :document, :options)

        EXPECTED_STATI = [ 200, 201 ]
        PRESENTER = Presenter::Document::Operation::Index

        FORCE_OPTIONS = {}

      private

        # Return response
        #
        # @return [Faraday::Response]
        #
        # @api private
        #
        def response
          connection.post(subject_path, document, effective_options)
        end
        memoize :response

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
          FORCE_OPTIONS = { :op_type => :create }.freeze
        end

        # Document index create command
        class Create < self
          EXPECTED_STATI = [ 201 ]
          FORCE_OPTIONS = { :op_type => :update }.freeze
        end
      end

      # Present get document command result
      class Get < self
        
        PRESENTER = Presenter::Document::Get

      private

        # Return response
        #
        # @return [Faraday::Presponse]
        #
        # @api private
        #
        def response
          connection.get(subject_path)
        end
        memoize :response

      end

      # Present delete document command result
      class Delete < self

        PRESENTER = Presenter::Document::Operation::Delete

      private

        # Return response
        #
        # @return [Faraday::Response]
        #
        # @api private
        #
        def response
          connection.delete(subject_path)
        end
        memoize :response

      end

    end
  end
end
