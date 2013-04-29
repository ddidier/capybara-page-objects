# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/elements/shared_examples_for_input'

describe CapybaraPageObjects::Elements::InputText do

  # ----------------------------------------------------------------------------------------------- Input examples -----

  it_behaves_like 'a CapybaraPageObjects::Elements::Input' do
    let(:input_class) { CapybaraPageObjects::Elements::InputText }
  end


  # ------------------------------------------------------------------------------------------- InputText examples -----

  before { visit '/elements/input_text' }
  let(:input) { CapybaraPageObjects::Elements::InputText.new(find('#my_input_text')) }

  # --------------------
  %W(value= text=).each do |method_name|
    describe "##{method_name}" do

      it 'sets the input value' do
        input.send(method_name, 'another_input_text_value')
        input.value.should eq('another_input_text_value')
      end

    end
  end

  # --------------------
  describe '#clear' do
    it 'clears the input value' do
      input.clear
      input.value.should be_empty
    end
  end

  # --------------------
  describe 'component registration' do
    it 'creates a #input_text method inside a CapybaraPageObjects::Page' do
      page_class = new_page_class('/elements/input_text')
      page_class.input_text :my_input_text, '#my_input_text'
      my_input_text = page_class.new.my_input_text
      my_input_text.should be_kind_of CapybaraPageObjects::Elements::InputText
      my_input_text.id.should eq('my_input_text')
    end
  end

end
