# -*- encoding : utf-8 -*-
require 'rspec/expectations'

module CapybaraPageObjects
  module RSpec
    module Matchers
      module Page

        # Ensures that a page has the specified title.
        #
        # Examples:
        #   MyPage.new.should have_title('Example') }
        #
        def have_title(title)
          HaveTitle.new(title)
        end

        # --------------------------------------------------------------------------------------------------------------
        class HaveTitle

          def initialize(expected_title = nil)
            @expected_title = expected_title
          end

          def matches?(actual_page)
            @actual_page = actual_page
            @actual_page_title = actual_page.title
            @actual_page_title == @expected_title
          end

          def description
            "have the title set to '#{@expected_title}'"
          end

          def failure_message_for_should
            <<-EOF.gsub(/^ {14}/, '')
              expected page '#{@actual_page.current_url}' to have its title set
                expected : #{@expected_title}
                actual   : #{@actual_page_title}
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
