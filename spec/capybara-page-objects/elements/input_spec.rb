# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/elements/shared_examples_for_input'

describe CapybaraPageObjects::Elements::Input do

  it_behaves_like 'a CapybaraPageObjects::Elements::Input' do
    let(:input_class) { CapybaraPageObjects::Elements::Input }
  end

end
