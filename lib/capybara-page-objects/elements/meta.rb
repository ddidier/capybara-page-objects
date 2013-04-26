# -*- encoding : utf-8 -*-
require 'capybara-page-objects/component'

module CapybaraPageObjects
  module Elements

    # An HTML <meta> header tag.
    class Meta < CapybaraPageObjects::Node

      # ----------------------------------------------------------------------------------------------- attributes -----

      # ----------------------------------------------------------------------------------------- instance methods -----

      # -------------------- public
      public


      # -------------------- protected
      protected

      # -------------------- private
      private

      private_class_method :new

      def initialize(source = nil, key_method_name, value_method_name, key_name, value_name)
        super(source)
        define_singleton_method key_method_name, lambda { source[key_name] }
        define_singleton_method value_method_name, lambda { source[value_name] } if value_method_name
      end

      # -------------------------------------------------------------------------------------------- class methods -----

      # -------------------- public
      public

      def self.with_http_equiv(key)
        from_xpath(%Q{//head/meta[@http-equiv="#{key}"]}, :http_equiv, :content, 'http-equiv')
      end

      def self.with_name(key)
        from_xpath(%Q{//head/meta[@name="#{key}"]}, :name, :content)
      end

      def self.charset
        from_xpath('//head/meta[@charset]', :charset)
      end

      def self.content_language
        with_http_equiv('Content-Language')
      end

      def self.content_type
        with_http_equiv('Content-Type')
      end

      def self.author
        with_name('author')
      end

      def self.copyright
        with_name('copyright')
      end

      def self.description
        with_name('description')
      end

      def self.keywords
        with_name('keywords')
      end

      # -------------------- protected
      protected

      # -------------------- private
      private

      def self.from_xpath(xpath_query, key_method_name, value_method_name = nil, key_name = nil, value_name = nil)
        new(Capybara.find(:xpath, xpath_query, visible: false),
            key_method_name,
            value_method_name,
            key_name || key_method_name,
            value_name || value_method_name)
      end

    end

  end
end
