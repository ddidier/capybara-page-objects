# -*- encoding : utf-8 -*-
require 'capybara-page-objects/node'

module CapybaraPageObjects
  class Component < Node

    # ------------------------------------------------------------------------------------------------- attributes -----

    # ------------------------------------------------------------------------------------------- instance methods -----

    # -------------------- public
    public

    def_delegators :@source, :visible?

    def hidden?
      not visible?
    end

    # -------------------- protected
    protected

    # -------------------- private
    private

    # ---------------------------------------------------------------------------------------------- class methods -----

    # -------------------- public
    public

    def self.field(name, &block)
      define_method(name, &block)
    end

    field(:id)  { source[:id]    }
    field(:css) { source[:class] }

    def has_css?(*classes)
      classes.each do |clazz|
        return false unless /(^|\s)#{clazz}($|\s)/.match(css)
      end
      true
    end

    # -------------------- protected
    protected

    # -------------------- private
    private

    # TODO enabled?, disabled?

  end
end
