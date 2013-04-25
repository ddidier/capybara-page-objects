# -*- encoding : utf-8 -*-
require 'facets/module/attr_class_accessor'

module CapybaraPageObjects

  # CapybaraPageObjects configuration.
  class Configuration

    attr_class_accessor :default_locale

    # Resets all the parameters
    def self.reset
      Configuration.default_locale = :en
    end

  end


  # --------------------------------------------------------------------------------------------------------------------

  Configuration.reset

end
