# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CapybaraPageObjects::Configuration do

  before { CapybaraPageObjects::Configuration.reset }

  # --------------------
  describe '#default_locale' do

    # --------------------
    context 'when not overriden' do
      it 'returns :en' do
        CapybaraPageObjects::Configuration.default_locale.should eq(:en)
      end
    end

    # --------------------
    context 'when overriden' do
      before { CapybaraPageObjects::Configuration.default_locale = :fr }

      it 'returns the overriden locale' do
        CapybaraPageObjects::Configuration.default_locale.should eq(:fr)
      end
    end

  end

  # --------------------
  describe '#reset' do

    # --------------------
    it 'resets the default locale' do
      CapybaraPageObjects::Configuration.default_locale = :fr
      CapybaraPageObjects::Configuration.reset
      CapybaraPageObjects::Configuration.default_locale.should eq(:en)
    end

  end

end
