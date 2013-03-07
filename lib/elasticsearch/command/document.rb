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
          connection.post(subject_path, document, options)
        end
        memoize :response

        # Document index update command
        class Update < self
          EXPECTED_STATI = [ 200 ]
          PRESENTER = Presenter::Document::Operation::Index

        private

          # Return response
          #
          # @return [Faraday::Response]
          #
          # @api private
          #
          def response
            connection.post(subject_path, document, options.merge(:op_type => :create))
          end
          memoize :response

        end

        # Document index create command
        class Create < self
          EXPECTED_STATI = [ 201 ]
          PRESENTER = Presenter::Document::Operation::Index

        private

          # Return response
          #
          # @return [Faraday::Response]
          #
          # @api private
          #
          def response
            connection.post(subject_path, document, options.merge(:op_type => :create))
          end
          memoize :response

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
