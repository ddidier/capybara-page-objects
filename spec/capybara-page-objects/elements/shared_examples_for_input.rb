# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_component'

#
# @param [Class] input_class the actual class of the input
#
shared_examples 'a CapybaraPageObjects::Elements::Input' do

  # ------------------------------------------------------------------------------------------- Component examples -----

  it_behaves_like 'a CapybaraPageObjects::Component' do
    let(:component_class) { input_class }
  end


  # --------------------------------------------------------------------------------------------- Element examples -----

  before { visit '/elements/input' }
  let(:input) { input_class.new(find('#my_input')) }

  # --------------------
  describe '#name' do
    it 'returns the input name' do
      input.name.should eq('my_input_name')
    end
  end

  # --------------------
  describe '#type' do
    it 'returns the input type' do
      input.type.should eq('my_type')
    end
  end

  # --------------------
  describe '#value' do
    it 'returns the input value' do
      input.value.should eq('my_input_value')
    end
  end

end
