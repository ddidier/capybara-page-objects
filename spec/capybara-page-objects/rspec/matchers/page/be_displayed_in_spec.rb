# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CapybaraPageObjects::RSpec::Matchers::Page::BeDisplayedIn, :type => 'matcher' do

  include CapybaraPageObjects::PageObjectSupport

  before { stub_page_in(:fr) }
  let(:page) { mock }

  # --------------------
  it 'matches when the expected Content-Language is equal to the actual one' do
    page.should be_displayed_in(:fr)
  end

  # --------------------
  it 'does not match when the expected Content-Language is different from the actual one' do
    page.should_not be_displayed_in(:en)
  end

  # --------------------
  it 'describes itself' do
    matcher = be_displayed_in(:fr)
    matcher.matches?(page)
    matcher.description.should == 'has Content-Language set to :fr'
  end

  # --------------------
  it 'provides message on #failure_message' do
    page.should_receive(:current_url).and_return('http://www.example.com/actual/url')
    matcher = be_displayed_in(:en)
    matcher.matches?(page)
    matcher.failure_message_for_should.should == <<-EOF.gsub(/^ {6}/, '')
      expected page 'http://www.example.com/actual/url' to have Content-Language set to
        expected : en
        actual   : fr
    EOF
  end

  # --------------------
  describe '#method_missing' do

    context 'when the mapping exists' do
      it 'matches when the expected Content-Language is equal to the actual one' do
        new_page('/page').should be_displayed_in_french
      end
      it 'does not match when the expected Content-Language is different from the actual one' do
        new_page('/page').should_not be_displayed_in_english
      end
    end

    context 'when the mapping does not exist' do
      it 'passes the call to the parent method_missing' do
        new_page('/page').should_not be_nil
      end
    end

  end


  # ----------------------------------------------------------------------------------------------- helper methods -----

  def stub_page_in(language)
    Capybara.stub!(:find) do |*args|
      page = Capybara.string <<-HTML
      <html>
        <head>
          <meta charset='UTF-8'>
          <meta http-equiv='Content-Language' content='#{language}'>
          <meta name='description' content='my description' />
          <title>have Content-Language tests support</title>
        </head>
        <body />
      </html>
      HTML

      page.find(*args)
    end
  end

end
