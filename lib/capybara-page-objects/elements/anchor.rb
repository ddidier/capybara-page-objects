# -*- encoding : utf-8 -*-
require 'capybara-page-objects/component'

module CapybaraPageObjects
  module Elements

    # An HTML <a> tag.
    class Anchor < CapybaraPageObjects::Component

      field(:link) { source[:href] }
      field(:text) { source.text   }

      def follow
        source.click
      end

    end

  end
end
