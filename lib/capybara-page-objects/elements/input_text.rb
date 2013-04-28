# -*- encoding : utf-8 -*-
require 'capybara-page-objects/elements/input'

module CapybaraPageObjects
  module Elements

    # An HTML <input> tag ot type text.
    class InputText < CapybaraPageObjects::Elements::Input

      def clear
        Capybara.fill_in key, with: ''
      end

      def value=(value)
        Capybara.fill_in key, with: value
      end

      alias_method :text, :value
      alias_method :text=, :value=

      private

      def key
        self.id || self.name
      end

    end

  end
end
