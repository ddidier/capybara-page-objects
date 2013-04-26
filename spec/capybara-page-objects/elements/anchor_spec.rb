# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_component'

describe CapybaraPageObjects::Elements::Anchor do

  # ------------------------------------------------------------------------------------------------ Node examples -----

  it_behaves_like 'a CapybaraPageObjects::Component' do
    let(:component_class) { CapybaraPageObjects::Elements::Anchor }
  end


  # --------------------------------------------------------------------------------------------- Element examples -----

  before { visit '/anchor' }
  let(:anchor) { CapybaraPageObjects::Elements::Anchor.new(find('#my_anchor')) }

  # --------------------
  describe '#link' do
    it 'returns the "href" attribute' do
      anchor.link.should eq('/node')
    end
  end

  # --------------------
  describe '#text' do
    it 'returns the text' do
      anchor.text.should eq('My anchor')
    end
  end

  # --------------------
  describe '#follow' do
    it 'clicks the link' do
      anchor.follow
      Capybara.current_url.should eq('http://www.example.com/node')
    end
  end


end
