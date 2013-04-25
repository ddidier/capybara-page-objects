# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_node'

describe CapybaraPageObjects::Node do

  # --------------------
  it_behaves_like 'a CapybaraPageObjects::Node' do
    let(:node_class) { CapybaraPageObjects::Node }
  end

  # --------------------
  describe '#source' do

    let(:node_instance) { CapybaraPageObjects::Node.new(source) }

    # --------------------
    context 'when source is specified' do
      let(:source) { mock }

      it 'returns the specified source' do
        node_instance.source.should eq(source)
      end
    end

    # --------------------
    context 'when source is not specified' do
      let(:source) { nil }

      it 'returns the Capybara current session' do
        node_instance.source.should eq(Capybara.current_session)
      end
    end

  end

end
