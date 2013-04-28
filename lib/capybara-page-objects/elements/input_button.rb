# -*- encoding : utf-8 -*-
require 'capybara-page-objects/elements/input'

module CapybaraPageObjects
  module Elements

    # An HTML <input> tag ot type submit, reset, or button.
    class InputButton < CapybaraPageObjects::Elements::Input

      def_delegators :source, :click

      alias_method :submit, :click
      alias_method :reset,  :click

    end

  end
end
