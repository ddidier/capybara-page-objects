# -*- encoding : utf-8 -*-

module CapybaraPageObjects

  # The absence of a node.
  # Wraps a query which returned nothing.
  class None

    attr_reader :query

    def initialize(*args)
      @query = Capybara::Query.new(*args)
    end

    def exist?
      false
    end

    def hidden?
      true
    end

    def visible?
      false
    end

    def locator
      query.locator
    end

    def selector
      query.selector.name
    end

    def source
      raise "#{self.class} has no source"
    end

  end

end
