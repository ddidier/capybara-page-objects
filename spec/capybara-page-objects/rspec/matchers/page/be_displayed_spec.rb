# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CapybaraPageObjects::RSpec::Matchers::Page::BeDisplayed, :type => 'matcher' do

  include CapybaraPageObjects::PageObjectSupport

  before { Capybara.current_session.should_receive(:current_path).and_return('/actual/path') }

  # --------------------
  it 'matches when the interpolated path is equal to the actual one' do
    new_page('/actual/path').should be_displayed
  end

  # --------------------
  it 'does not match when the interpolated path is different from the actual one' do
    new_page('/another/path').should_not be_displayed
  end

  # --------------------
  it 'describes itself' do
    page = new_page('/actual/path')
    matcher = be_displayed
    matcher.matches?(page)
    matcher.description.should == "is displayed at '/actual/path'"
  end

  # --------------------
  it 'provides message on #failure_message' do
    page = new_page('/another/path')
    matcher = be_displayed
    matcher.matches?(page)
    matcher.failure_message_for_should.should == <<-EOF.gsub(/^ {6}/, '')
      expected page path to be: /another/path
                       but was: /actual/path
    EOF
  end

end
