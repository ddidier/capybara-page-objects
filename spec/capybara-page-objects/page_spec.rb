# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_page'

describe CapybaraPageObjects::Page do

  # ------------------------------------------------------------------------------------------------ Page examples -----

  it_behaves_like 'a CapybaraPageObjects::Page' do
    let(:page_class) { CapybaraPageObjects::Page }
  end

end
