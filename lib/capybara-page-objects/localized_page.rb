# -*- encoding : utf-8 -*-
require 'capybara-page-objects/page'

module CapybaraPageObjects

  # An HTML page in a given language.
  #
  # Each subclass must define a parameterized path using the <tt>#path</tt>
  # class method. These parameters are then specified on instance creation.
  # One of these parameter may be the page locale.
  class LocalizedPage < Page

    # ------------------------------------------------------------------------------------------------- attributes -----

    # ------------------------------------------------------------------------------------------- instance methods -----

    # -------------------- public
    public

    # Returns the specified path parameters merged with the default locale
    # if none was provided.
    def path_parameters
      { locale: Configuration.default_locale }.merge(super)
    end

    def locale
      path_parameters[:locale]
    end

    # -------------------- protected
    protected

    # -------------------- private
    private

    # ---------------------------------------------------------------------------------------------- class methods -----

    # -------------------- public
    public

    # Defines the raw path on the class with a leading <tt>/:locale/</tt>.
    # The raw path will be interpolated on instance creation.
    def self.path(p)
      localized_path = p.start_with?('/') ? "/:locale#{p}" : "/:locale/#{p}"
      define_method(:raw_path) { localized_path }
    end

    # -------------------- protected
    protected

    # -------------------- private
    private

  end

end
