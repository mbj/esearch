module Elasticsearch
  # A specific facet in a result 
  class Facet
    include Adamantium::Flat, Enumerable, Equalizer.new(:name, :to_a)

    attr_reader :name

    def type
      Facet::Type.get(@data.fetch('_type'))
    end
    memoize :type

    def each
      return to_enum unless block_given?

      type = self.type

      @data.fetch(type.field_name).each do |document|
        yield type.new(document)
      end

      self
    end

  private

    # Initialize object
    #
    # @param [String] name
    # @param [Hash] data
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(name, data)
      @name, @data = name, data
    end
  end
end
