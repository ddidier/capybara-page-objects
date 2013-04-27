# -*- encoding : utf-8 -*-

module CapybaraPageObjects
  module PageObjectSupport

    # ---------------------------------------------------------------------------------- CapybaraPageObjects::Page -----

    def new_page_class(path, page_class = CapybaraPageObjects::Page)
      Class.new(page_class) { self.path(path) }
    end

    def new_page(path, page_class = CapybaraPageObjects::Page, *args)
      new_page_class(path).new(*args)
    end

    def visit_new_page(path, page_class = CapybaraPageObjects::Page, *args)
      new_page(path, *args).tap { |page| page.visit }
    end

  end
end
