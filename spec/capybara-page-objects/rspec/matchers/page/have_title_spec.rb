# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CapybaraPageObjects::RSpec::Matchers::Page::HaveTitle, :type => 'matcher' do

  before(:each) do
    @page = mock
    @page.should_receive(:title).and_return('actual_title')
  end

  # --------------------
  it 'matches when the expected title is equal to the actual one' do
    @page.should have_title('actual_title')
  end

  # --------------------
  it 'does not match when the expected title is different from the actual one' do
    @page.should_not have_title('another_title')
  end

  # --------------------
  it 'describes itself' do
    matcher = have_title('actual_title')
    matcher.matches?(@page)
    matcher.description.should == "have the title set to 'actual_title'"
  end

  # --------------------
  it 'provides message on #failure_message' do
    @page.should_receive(:current_url).and_return('actual_url')
    matcher = have_title('another_title')
    matcher.matches?(@page)
    matcher.failure_message_for_should.should == <<-EOF.gsub(/^ {6}/, '')
      expected page 'actual_url' to have its title set
        expected : another_title
        actual   : actual_title
    EOF
  end

end
