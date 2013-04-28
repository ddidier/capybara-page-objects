# -*- encoding : utf-8 -*-
require 'rspec/expectations'
require 'facets/module/alias_method_chain'
require 'capybara-page-objects/elements/meta'

module CapybaraPageObjects
  module RSpec
    module Matchers
      module Page

        # Ensures that a page has the specified Content-Language meta tag.
        #
        # Examples:
        #   MyPage.new.should be_displayed_in(:fr)
        #
        #   MyPage.new.should be_displayed_in_english
        #   MyPage.new.should be_displayed_in_french
        #
        def be_displayed_in(language)
          BeDisplayedIn.new(language)
        end

        # --------------------------------------------------------------------------------------------------------------
        class BeDisplayedIn

          def initialize(expected_language)
            @expected_language = expected_language.to_sym
          end

          def matches?(actual_page)
            @actual_page = actual_page
            @actual_language = CapybaraPageObjects::Elements::Meta.content_language.content.to_sym
            @actual_language == @expected_language
          end

          def description
            "has Content-Language set to :#{@expected_language}"
          end

          def failure_message_for_should
            <<-EOF.gsub(/^ {14}/, '')
              expected page '#{@actual_page.current_url}' to have Content-Language set to
                expected : #{@expected_language}
                actual   : #{@actual_language}
            EOF
          end

          def ==(other)
            matches?(other)
          end

          # --------------------
          # let's have a little fun :-)
          LANGUAGE_MAP = {
              'english' => :en,
              'french'  => :fr,
              'german'  => :de,
              'italian' => :it,
              'spanish' => :es,
          }

          def self.map(language)
            locale = LANGUAGE_MAP[language.to_s]
            locale ? BeDisplayedIn.new(locale) : nil
          end

        end

      end
    end
  end
end


module RSpec
  module Matchers

    private

    def self.included(base)
      alias_method_chain :method_missing, :be_displayed_in
    end

    def method_missing_with_be_displayed_in(method_symbol, *arguments, &block)
      if method_symbol.to_s =~ /^be_displayed_in_(.+)$/
        locale = CapybaraPageObjects::RSpec::Matchers::Page::BeDisplayedIn::LANGUAGE_MAP[$1.to_s]
        return CapybaraPageObjects::RSpec::Matchers::Page::BeDisplayedIn.new(locale) if locale
      end
      method_missing_without_be_displayed_in(method_symbol, *arguments, &block)
    end

  end
end
