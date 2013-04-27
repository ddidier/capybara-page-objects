# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CapybaraPageObjects::RSpec::Matchers::Page::BeDisplayedAtUrl, :type => 'matcher' do

  include CapybaraPageObjects::PageObjectSupport

  before(:each) do
    Capybara.current_session.should_receive(:current_url).and_return('http://www.example.com/actual/url')
  end

  # --------------------
  it 'matches when the expected URL is equal to the actual one' do
    new_page('http://www.example.com/actual/url').should be_displayed_at_url('http://www.example.com/actual/url')
  end

  # --------------------
  it 'does not match when the expected URL is different from the actual one' do
    new_page('http://www.example.com/another/url').should_not be_displayed_at_url('http://www.example.com/another/url')
  end

  # --------------------
  it 'describes itself' do
    page = new_page('http://www.example.com/actual/url')
    matcher = be_displayed_at_url('http://www.example.com/actual/url')
    matcher.matches?(page)
    matcher.description.should == "is displayed at URL 'http://www.example.com/actual/url'"
  end

  # --------------------
  it 'provides message on #failure_message' do
    page = new_page('http://www.example.com/another/url')
    matcher = be_displayed_at_url('http://www.example.com/another/url')
    matcher.matches?(page)
    matcher.failure_message_for_should.should == <<-EOF.gsub(/^ {6}/, '')
      expected page URL to be: http://www.example.com/another/url
                      but was: http://www.example.com/actual/url
    EOF
  end

end
