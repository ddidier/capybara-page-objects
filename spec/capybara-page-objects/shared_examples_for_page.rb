# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_node'

#
# @param [Class] page_class the actual class of the page
# @param [String] page_path the raw path of the page
# @param [String] current_path the actual path of the current session
#
shared_examples 'a CapybaraPageObjects::Page' do

  around(:each) do |example|
    with_page_object_class(page_class) do
      example.run
    end
  end

  # ------------------------------------------------------------------------------------------------ Node examples -----

  it_behaves_like 'a CapybaraPageObjects::Node' do
    let(:node_class) { new_page_class(page_path) }
  end

  # --------------------
  describe '#source' do
    let(:node_instance) { new_page_class(page_path).new(source) }

    # --------------------
    context 'when source is specified' do
      let(:source) { mock }

      it 'returns the specified source' do
        node_instance.source.should eq(Capybara.current_session)
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


  # ------------------------------------------------------------------------------------------------ Page examples -----

  # --------------------
  describe '#title' do
    it 'returns the title of the page' do
      visit_new_page(page_path).title.should eq('Dummy Title')
    end
  end

  # --------------------
  describe '#current_path' do
    it 'returns the current actual path of the page' do
      visit_new_page(page_path).current_path.should eq(current_path)
    end
  end

  # --------------------
  describe '#current_url' do
    it 'returns the current actual URL of the page' do
      visit_new_page(page_path).current_url.should eq("http://www.example.com#{current_path}")
    end
  end

  # --------------------
  describe '#session' do
    it 'returns the current session' do
      visit_new_page(page_path).session.should eq(Capybara.current_session)
    end
  end

  # --------------------
  describe '#displayed?' do

    it 'returns true if the interpolated path is equal to the current path' do
      Capybara.current_session.should_receive(:current_path).and_return(current_path)
      new_page(page_path).should be_displayed
    end

    it 'returns true if the interpolated path is equal to the current path with a trailing slash' do
      Capybara.current_session.should_receive(:current_path).and_return(current_path)
      new_page(page_path).should be_displayed
    end

    it 'returns true if the interpolated path is equal to the current path without a trailing slash' do
      Capybara.current_session.should_receive(:current_path).and_return(current_path)
      new_page(page_path).should be_displayed
    end

    it 'returns false if the interpolated path is not equal to the current path' do
      Capybara.current_session.should_receive(:current_path).and_return('/another_path')
      new_page(page_path).should_not be_displayed
    end

  end

  # --------------------
  describe '#visit' do
    before { Capybara.current_session.should_receive(:visit).with(current_path) }

    it 'visits the specified path' do
      visit_new_page(page_path)
    end
  end

end
