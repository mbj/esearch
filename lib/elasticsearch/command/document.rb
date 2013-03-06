module Elasticsearch
  class Command
    # Base class for commands on documents
    class Document < self

      # Document index command
      class Index < self
        include Composition.new(:subject, :document, :options)

        EXPECTED_STATI = [ 200, 201 ]
        PRESENTER = Presenter::Document::Operation::Index

      private

        # Return response
        #
        # @return [Faraday::Response]
        #
        # @api private
        #
        def response
          connection.post(subject.path, document, options)
        end
        memoize :response

      end

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
          connection.get(subject.path)
        end
        memoize :response

      end

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
          connection.delete(subject.path)
        end
        memoize :response

      end

    end
  end
end
