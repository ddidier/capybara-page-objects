# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/elements/shared_examples_for_input'

describe CapybaraPageObjects::Elements::InputButton do

  # ----------------------------------------------------------------------------------------------- Input examples -----

  it_behaves_like 'a CapybaraPageObjects::Elements::Input' do
    let(:input_class) { CapybaraPageObjects::Elements::InputButton }
  end


  # ----------------------------------------------------------------------------------------- InputButton examples -----

  before { visit '/elements/input_button' }
  let(:input) { CapybaraPageObjects::Elements::InputButton.new(find('#my_input_button')) }

  # --------------------
  %W(click submit reset).each do |method_name|
    describe "##{method_name}" do

      it 'clicks the input button' do
        input.source.should_receive(:click)
        input.send(method_name)
      end

    end
  end

end
