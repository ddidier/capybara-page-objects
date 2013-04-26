# -*- encoding : utf-8 -*-

class ElementsController < HighVoltage::PagesController

  private

  def page_finder_factory
    ElementPageFinder
  end

  # ------------------------------------------------------------------------------------------------------ classes -----

  class ElementPageFinder < HighVoltage::PageFinder
    def content_path
      super + 'elements/'
    end
  end

end
