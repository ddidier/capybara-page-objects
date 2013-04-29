# -*- encoding : utf-8 -*-
require 'capybara-page-objects/component'
require 'capybara-page-objects/page'

module CapybaraPageObjects
  module Elements

    # An HTML <a> tag.
    class Anchor < CapybaraPageObjects::Component

      field(:link) { source[:href] }
      field(:text) { source.text }

      def follow
        source.click
      end

    end


    # Registering component as 'anchor'
    CapybaraPageObjects::Page.register_component(Anchor, :anchor)

  end
end
