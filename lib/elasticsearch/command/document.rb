module Elasticsearch
  class Command
    # Base class for commands on documents
    class Document < self

      # Document index command
      class Index < self
        include Composition.new(:subject, :document, :options)

        EXPECTED_STATI = [ 200, 201 ]
        PRESENTER = Presenter::Command::Document::Index

      private

        # Return response
        #
        # @return [Faraday::Response]
        #
        # @api private
        #
        def response
          connection.post_body_query(subject.path, document, options)
        end
        memoize :response

      end

    end
  end
end
