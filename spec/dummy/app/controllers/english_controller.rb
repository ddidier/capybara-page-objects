# -*- encoding : utf-8 -*-

class EnglishController < HighVoltage::PagesController

  private

  def page_finder_factory
    EnglishPageFinder
  end

  # ------------------------------------------------------------------------------------------------------ classes -----

  class EnglishPageFinder < HighVoltage::PageFinder
    def content_path
      super + 'en/'
    end
  end

end
