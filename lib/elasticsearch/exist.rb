module Elasticsearch

  # Mixin for exist command
  module Exist
    # Test if index does exist
    #
    # @return [true]
    #   if index exists
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def exist?
      Command::Exist.run(self)
    end
  end
end
