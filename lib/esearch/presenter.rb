module Esearch
  # Abstract base class for json response presenters
  class Presenter
    include Adamantium::Flat, AbstractType, Concord.new(:raw)

    # Define tagged collection exposer
    #
    # @param [Symbol] name
    # @param [Class:Presenter] presenter
    #
    # @return [undefined]
    #
    # @api private
    #
    def self.expose_tagged_collection(key, presenter)
      key = key.to_s # caches string in closure ;)
      define_method(key) do ||
        raw.fetch(key).map do |name, element| 
          presenter.new(element.merge('name' => name))
        end
      end
    end
    private_class_method :expose_tagged_collection

    # Define primitive exposer
    #
    # @param [Symbol] key
    # @param [Symbol] method_name
    #
    # @return [undefined]
    #
    # @api private
    #
    def self.expose_primitive(key, method_name = key)
      key = key.to_s # caches string in closure ;)
      define_method(method_name) do ||
        raw.fetch(key)
      end
    end
    private_class_method :expose_primitive

  end
end
