module Elasticsearch
  # Interface to a specific elasticsearch type
  class Type
    include Adamantium::Flat, Composition.new(:index, :name)

  private

    # Return connection
    #
    # @return [Faraday::Connection]
    #
    # @api private
    #
    def connection
      index.connection
    end
  end
end
