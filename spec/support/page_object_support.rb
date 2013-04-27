# -*- encoding : utf-8 -*-

module CapybaraPageObjects
  module PageObjectSupport

    def new_page_class(path)
      Class.new(page_object_class) { self.path(path) }
    end

    def new_page(path, *args)
      new_page_class(path).new(*args)
    end

    def visit_new_page(path, *args)
      new_page(path, *args).tap { |page| page.visit }
    end

    def with_page_object_class(page_object_class, &block)
      @page_object_class = page_object_class
      yield
      @page_object_class = nil
    end

    # --------------------
    private

    def page_object_class
      @page_object_class || CapybaraPageObjects::Page
    end

  end
end
