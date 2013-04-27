# -*- encoding : utf-8 -*-

class FrenchController < HighVoltage::PagesController

  private

  def page_finder_factory
    FrenchPageFinder
  end

  # ------------------------------------------------------------------------------------------------------ classes -----

  class FrenchPageFinder < HighVoltage::PageFinder
    def content_path
      super + 'fr/'
    end
  end

end
