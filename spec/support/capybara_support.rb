# -*- encoding : utf-8 -*-

module CapybaraPageObjects
  module CapybaraSupport

    def with_no_wait_time(&block)
      default_wait_time = Capybara.default_wait_time
      Capybara.default_wait_time = 0
      yield
      Capybara.default_wait_time = default_wait_time
    end

    # -------------------------------------------------------------------------------------------------- utilities -----

    def nil_if_empty(object)
      return nil if object.empty?
      object
    end

  end
end
