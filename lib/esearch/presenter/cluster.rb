module Esearch
  class Presenter
    # Base class for cluster presenters
    class Cluster < self

      # Presenter for cluster health
      class Health < self

        # Return cluster name
        #
        # @return [String]
        #
        # @api private
        #
        expose_primitive('name')

        # Return status string
        #
        # @return [String]
        #
        # @api private
        #
        expose_primitive('status')

        # Return number of nodes
        #
        # @return [String]
        #
        # @api private
        #
        expose_primitive('number_of_nodes')

        # Return number of data nodes
        #
        # @return [Fixnum]
        #
        # @api private
        #
        expose_primitive('number_of_data_nodes')

        # Return number of active primary shards
        #
        # @return [Fixnum]
        #
        # @api private
        #
        expose_primitive('active_primary_shards')

        # Return number of active shards
        #
        # @return [Fixnum]
        #
        # @api private
        #
        expose_primitive('active_shards')

        # Return number of relocating shards
        #
        # @return [Fixnum]
        #
        # @api private
        #
        expose_primitive('relocating_shards')

        # Return number of initializing shards
        #
        # @return [Fixnum]
        #
        # @api private
        #
        expose_primitive('initializing_shards')

        # Return number of unassigned shards
        #
        # @return [Fixnum]
        #
        # @api private
        #
        expose_primitive('unassigned_shards')

      end # Health
    end # Cluster
  end # Presenter
end # Esearch
