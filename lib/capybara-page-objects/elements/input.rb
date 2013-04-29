# -*- encoding : utf-8 -*-
require 'capybara-page-objects/component'
require 'capybara-page-objects/page'

module CapybaraPageObjects
  module Elements

    # An HTML <input> tag.
    class Input < CapybaraPageObjects::Component

      field(:name)  { source[:name]  }
      field(:type)  { source[:type]  }
      field(:value) { source[:value] }

    end


    # Registering component as 'input'
    CapybaraPageObjects::Page.register_component(Input, :input)

  end
end
