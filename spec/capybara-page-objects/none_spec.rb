# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CapybaraPageObjects::None do

  let(:none) { CapybaraPageObjects::None.new(:xpath, '#invalid_id') }

  # --------------------
  describe '#exist?' do
    it 'returns false' do
      none.should_not exist
    end
  end

  # --------------------
  describe '#hidden?' do
    it 'returns true' do
      none.should be_hidden
    end
  end

  # --------------------
  describe '#visible?' do
    it 'returns false' do
      none.should_not be_visible
    end
  end

  # --------------------
  describe '#locator' do
    it 'returns the requested locator' do
      none.locator.should eq('#invalid_id')
    end
  end

  # --------------------
  describe '#selector' do
    it 'returns the requested selector' do
      none.selector.should eq(:xpath)
    end
  end

  # --------------------
  describe '#query' do
    it 'wraps the requested query' do
      none.query.should be_kind_of Capybara::Query
      none.query.locator.should eq('#invalid_id')
      none.query.selector.name.should eq(:xpath)
    end
  end

  # --------------------
  describe '#source' do
    it 'raises an error' do
      expect { none.source }.to raise_error("CapybaraPageObjects::None has no source")
    end
  end

end
