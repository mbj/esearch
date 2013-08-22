module Esearch
  class Command
    # Base class for cluster commands
    class Cluster < self

      # Command for accessing health
      class Health < self
        include Concord.new(:context, :options)

        PRESENTER = Presenter::Cluster::Health

      private

        # Return request
        #
        # @return [Request]
        #
        # @api private
        #
        def request
          Request.get('/_cluster/health', {}, options)
        end

      end

      class Aliases < self

        class Update < self
          include Concord.new(:context, :settings)

          EXPECT_STATUS = [ 200 ].freeze
          PRESENTER = Presenter::Cluster::Aliases::Update

        private

          # Return request
          #
          # @return [Request]
          #
          # @api private
          #
          def request
            Request.post('/_aliases', settings)
          end
        end

      end

    end
  end
end
