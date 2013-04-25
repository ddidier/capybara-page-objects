# -*- encoding : utf-8 -*-
require 'rubygems'
require 'spork'


# Start code coverage if:
# - the 'COVERAGE' environment variable is set
# - the 'DRB' environment variable is not set, ie. Spork is not running
def configure_code_coverage
  if ENV["COVERAGE"] and not ENV['DRB']
    require 'simplecov'
    require 'launchy'

    SimpleCov.start do
      add_filter "/spec/"
    end

    SimpleCov.at_exit do
      SimpleCov.result.format!
      if SimpleCov.result.covered_percent < 100
        Launchy.open("coverage/index.html")
      end
    end
  end
end

# Reload all Ruby files in the given directory.
def reload_files(directory)
  Dir["#{directory}/**/*.rb"].each { |file| load file }
end

# Some directories
spec_dir = File.dirname(__FILE__)
root_dir = "#{spec_dir}/.."
app_dir  = "#{spec_dir}/dummy"


# ----------------------------------------------------------------------------------------------------------------------
# Spork prefork
# Loading more in this block will cause your tests to run faster. However, if you change any
# configuration or code from libraries loaded here, you'll need to restart spork for it take effect.
# ----------------------------------------------------------------------------------------------------------------------

Spork.prefork do

 #$LOAD_PATH.unshift("#{spec_dir}")
 #$LOAD_PATH.unshift("#{spec_dir}/lib")

  configure_code_coverage

  # -------------------- rails

  ENV['RAILS_ENV'] ||= 'test'

  require "#{app_dir}/config/environment"
  require 'rspec/rails'

  # -------------------- filters

  RSpec.configure do |config|

    # This allows you to tag a group or example like this:
    #     describe "something slow", :slow do ...
    # instead of having to type:
    #     describe "something slow", :slow => true do ...
    config.treat_symbols_as_metadata_keys_with_true_values = true

    # This allows you to write an example like this:
    #     fit "does something" do ...
    # instead of having to type:
    #     it "does something", :focused => true do
    config.alias_example_to :fit, :focused

    # Filter tagged examples
    config.filter_run :focused

    # Run all if there is no tagged example
    config.run_all_when_everything_filtered = true

    # If true, the base class of anonymous controllers will be inferred automatically.
    #config.infer_base_class_for_anonymous_controllers = true

    # Run specs in random order to surface order dependencies. If you find an order dependency and want to debug it,
    # you can fix the order by providing the seed, which is printed after each run.
    config.order = "random"

    # Mock framework to use
    config.mock_with :rspec

  end

  # -------------------- capybara

  require 'capybara/rspec'
  require 'capybara/rails'
  require 'capybara/poltergeist'
 #require 'capybara-page-objects'
 #require 'capybara-page-objects/rspec/matchers'

  RSpec.configure do |config|

    #config.before(:each) do
    #  Capybara.current_driver = :poltergeist if example.metadata[:js]
    #end
    #
    #config.after(:each) do
    #  Capybara.use_default_driver if example.metadata[:js]
    #end
    #
    #config.before(:each) do
    #  Capybara.current_driver = :poltergeist
    #  Capybara.app_host = "#{File.dirname(__FILE__)}/pages/"
    #end

    config.include Capybara::DSL
   #config.include CapybaraPageObjects::RSpec::Matchers

  end

end


# ----------------------------------------------------------------------------------------------------------------------
# Spork each_run
# This code will be run each time you run your specs.
# ----------------------------------------------------------------------------------------------------------------------

Spork.each_run do

  configure_code_coverage

  # -------------------- files reload

  reload_files("#{root_dir}/lib")
  reload_files("#{root_dir}/spec/support")

  # -------------------- support

  RSpec.configure do |config|
    config.include CapybaraPageObjects::CapybaraSupport
  end

end
