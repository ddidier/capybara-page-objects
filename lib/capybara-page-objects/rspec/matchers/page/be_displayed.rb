# -*- encoding : utf-8 -*-
require 'rspec/expectations'

module CapybaraPageObjects
  module RSpec
    module Matchers
      module Page

        # Ensures that a page is displayed by comparing its interpolated path with the current path.
        #
        # Examples:
        #   MyPage.new.should be_displayed
        #
        def be_displayed
          BeDisplayed.new
        end

        # --------------------------------------------------------------------------------------------------------------
        class BeDisplayed

          def matches?(actual_page)
            @actual_page_path = actual_page.path
            @actual_page_path == expected_page_path
          end

          def description
            "is displayed at '#{expected_page_path}'"
          end

          def failure_message_for_should
            <<-EOF.gsub(/^ {14}/, '')
              expected page path to be: #{@actual_page_path}
                               but was: #{expected_page_path}
            EOF
          end

          def ==(other)
            matches?(other)
          end

          # --------------------
          private

          def expected_page_path
            @expected_page_path ||= Capybara.current_session.current_path
          end
        end

      end
    end
  end
end
