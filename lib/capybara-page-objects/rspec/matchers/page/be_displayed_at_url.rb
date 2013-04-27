# -*- encoding : utf-8 -*-
require 'rspec/expectations'

module CapybaraPageObjects
  module RSpec
    module Matchers
      module Page

        # Ensures that a page is displayed by comparing the specified URL with the current path.
        #
        # Examples:
        #   MyPage.new.should be_be_displayed_at_url('http://www.example.com')
        #
        def be_displayed_at_url(title)
          BeDisplayedAtUrl.new(title)
        end

        # --------------------------------------------------------------------------------------------------------------
        class BeDisplayedAtUrl

          def initialize(expected_url)
            @expected_page_url = expected_url
          end

          def matches?(actual_page)
            @actual_page_url = actual_page.current_url
            @actual_page_url == @expected_page_url
          end

          def description
            "is displayed at URL '#{@expected_page_url}'"
          end

          def failure_message_for_should
            <<-EOF.gsub(/^ {14}/, '')
              expected page URL to be: #{@expected_page_url}
                              but was: #{@actual_page_url}
            EOF
          end

          def ==(other)
            matches?(other)
          end

        end

      end
    end
  end
end
