# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_component'

describe CapybaraPageObjects::Elements::Anchor do

  # ------------------------------------------------------------------------------------------- Component examples -----

  it_behaves_like 'a CapybaraPageObjects::Component' do
    let(:component_class) { CapybaraPageObjects::Elements::Anchor }
  end


  # --------------------------------------------------------------------------------------------- Element examples -----

  before { visit '/elements/anchor' }
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

  # --------------------
  describe 'component registration' do
    it 'creates a #anchor method inside a CapybaraPageObjects::Page' do
      page_class = new_page_class('/elements/anchor')
      page_class.anchor :my_anchor, '#my_anchor'
      my_anchor = page_class.new.my_anchor
      my_anchor.should be_kind_of CapybaraPageObjects::Elements::Anchor
      my_anchor.id.should eq('my_anchor')
      my_anchor.text.should eq('My anchor')
    end
  end

end
