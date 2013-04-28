# -*- encoding : utf-8 -*-
require 'capybara-page-objects/rspec/matchers/page/be_displayed'
require 'capybara-page-objects/rspec/matchers/page/be_displayed_at_url'
require 'capybara-page-objects/rspec/matchers/page/be_displayed_in'
require 'capybara-page-objects/rspec/matchers/page/have_title'


module CapybaraPageObjects
  module RSpec
    module Matchers

      include CapybaraPageObjects::RSpec::Matchers::Page

    end
  end
end


RSpec.configure do |config|
  config.include CapybaraPageObjects::RSpec::Matchers, :type => :feature
end
