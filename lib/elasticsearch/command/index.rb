module Elasticsearch
  class Command
    # Base class for commands on index
    class Index < self
      class Create < self
        include Composition.new(:subject, :settings)

        EXPECT_STATUS = [ 201 ].freeze
        PRESENTER = Presenter::Command::Index::Create

      private

        # Return response
        #
        # @return [Faraday::Response]
        #
        # @api private
        #
        def response
          connection.put(subject.path, settings)
        end
        memoize :response

      end

      class Delete < self

        EXPECT_STATUS = [ 200 ].freeze
        PRESENTER = Presenter::Command::Index::Delete

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

      # Command to refresh index
      class Refresh < self

        PRESENTER = Presenter::Command::Index::Refresh

      private

        # Return response
        #
        # @return [Faraday::Response]
        #
        # @api private
        #
        def response
          connection.post(subject.path.join('_refresh'))
        end

      end
    end
  end
end
