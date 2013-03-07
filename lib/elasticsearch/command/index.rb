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

        # Return response
        #
        # @return [Faraday::Response]
        #
        # @api private
        #
        def response
          connection.put(subject_path, settings)
        end
        memoize :response

      end

      # Delete index comand
      class Delete < self

        PRESENTER = Presenter::Index::Delete

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

      # Refresh index command
      class Refresh < self

        PRESENTER = Presenter::Index::Refresh

      private

        # Return response
        #
        # @return [Faraday::Response]
        #
        # @api private
        #
        def response
          connection.post(subject_path.join('_refresh'))
        end
        memoize :response

      end
    end
  end
end
