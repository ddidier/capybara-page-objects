# -*- encoding : utf-8 -*-
require 'capybara-page-objects/component'

module CapybaraPageObjects
  module Elements

    # An HTML <input> tag.
    class Input < CapybaraPageObjects::Component

      field(:name)  { source[:name]  }
      field(:type)  { source[:type]  }
      field(:value) { source[:value] }

    end

  end
end
