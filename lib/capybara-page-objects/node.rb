# -*- encoding : utf-8 -*-
require 'facets/string/underscore'
require 'capybara-page-objects/none'

module CapybaraPageObjects

  # Base class of all pages, elements and components. Wraps a Capybara source.
  class Node
    extend Forwardable

    # ------------------------------------------------------------------------------------------------- attributes -----

    attr_reader :source

    # ------------------------------------------------------------------------------------------- instance methods -----

    # -------------------- public
    public

    # Creates a new node instance wrapping the given source
    # which defaults to the Capybara current session.
    def initialize(source = nil)
      @source = source || Capybara.current_session
    end

    # -------------------- protected
    protected

    # Delegates all the finder methods to the source and
    # made them protected since this should not be a public API.
    Capybara::Node::Finders.instance_methods(false).each do |finder|
      define_method finder do |*args|
        source.send(finder, *args)
      end
      protected finder
    end

    # Returns a node of the given class and located with the given query,
    # or CapybaraPageObjects::None if none was found. The search is scoped
    # to the current node.
    def find_or_none(node_class, *query)
      node_class.new(find(*query))
    rescue Capybara::ElementNotFound
      CapybaraPageObjects::None.new(*query)
    end

    # -------------------- private
    private

    # Allows to set a value directly on a component, if this component has a :value= method.
    #
    # Example:
    #   class MyNode < CapybaraPageObjects::Node
    #     component :email, InputText, '#email_field'
    #   end
    # Then you can use:
    #   MyNode.new.email = 'admin@example.com'
    # Instead of:
    #   MyNode.new.email.value = 'admin@example.com'
    #
    def method_missing(method_symbol, *arguments, &block)
      if method_symbol.to_s =~ /^(.+)=$/
        send($1).send(:value=, *arguments)
      else
        super
      end
    rescue NoMethodError
      super
    end

    # ---------------------------------------------------------------------------------------------- class methods -----

    # -------------------- public
    public

    # -------------------- protected
    protected

    # -------------------- private
    private

    # Adds a factory method returning a node of the given class and located
    # with the given query, or CapybaraPageObjects::None if none was found.
    # The search is scoped to the current node.
    #
    # Several variants:
    #   component(:component_name) { component }
    #   component :component_name, ComponentClass, 'selector'
    #   component :component_name, ComponentClass, 'selector', :selector_type
    #
    # Examples:
    #   class MyNode
    #     component(:link_1) { CapybaraPageObjects::Node.new(find('#link_1')) }
    #     component :link_2,   CapybaraPageObjects::Node, '#link_2'     # default to :css
    #     component :link_3,   CapybaraPageObjects::Node, '//a[1]',     :xpath
    #     component :input_1,  CapybaraPageObjects::Node, 'input_name', :field
    #   end
    def self.component(name, *args, &block)
      if block
        raise ArgumentError.new(component_usage) unless args.empty?
        define_method(name, &block)
      else
        raise ArgumentError.new(component_usage) unless args.length.between?(2, 3)
        klass, selector, selector_type = args
        define_method(name) do
          find_or_none(klass, selector_type || Capybara.default_selector, selector)
        end
      end
    end

    def self.component_usage
      <<-EOF.gsub(/^ {6}/, '')
      CapybaraPageObjects::Node#component usage (4 variants):
         1. component(:component_name) { CapybaraPageObjects::Node.new(find('a')) }
         2. component :component_name, CapybaraPageObjects::Node, 'a'
         3. component :component_name, CapybaraPageObjects::Node, 'a', :css
         4. component :component_name, CapybaraPageObjects::Node, 'a', :xpath
      EOF
    end

    # Creates a specialized factory method.
    #
    # Several variants:
    #   register_component ComponentClass
    #   register_component ComponentClass, :component_name
    #
    # Examples:
    #   class MyNode
    #     link_1 '#link_1'
    #     link_2 '//a[1]', :xpath
    #   end
    def self.register_component(component_class, component_class_name = nil)
      component_class_name ||= component_class.name.underscore

      define_singleton_method(component_class_name) do |name, selector, type = Capybara.default_selector|
        component(name, component_class, selector, type)
      end
    end

  end
end
