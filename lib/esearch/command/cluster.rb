# encoding: UTF-8

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

      end # Health

    end # Cluster
  end # Command
end # Esearch
