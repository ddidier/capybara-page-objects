# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_component'

describe CapybaraPageObjects::Component do

  # ------------------------------------------------------------------------------------------------ Node examples -----

  it_behaves_like 'a CapybaraPageObjects::Component' do
    let(:component_class) { CapybaraPageObjects::Component }
  end
  #it_behaves_like 'a CapybaraPageObjects::Node' do
  #  let(:node_class) { CapybaraPageObjects::Component }
  #end
  #
  ## --------------------
  #describe '#source' do
  #  let(:node_instance) { CapybaraPageObjects::Component.new(source) }
  #
  #  # --------------------
  #  context 'when source is specified' do
  #    let(:source) { mock }
  #
  #    it 'returns the specified source' do
  #      node_instance.source.should eq(source)
  #    end
  #  end
  #
  #  # --------------------
  #  context 'when source is not specified' do
  #    let(:source) { nil }
  #
  #    it 'returns the Capybara current session' do
  #      node_instance.source.should eq(Capybara.current_session)
  #    end
  #  end
  #
  #end
  #
  #
  ## ------------------------------------------------------------------------------------------- Component examples -----
  #
  #before { visit '/component' }
  #
  ## --------------------
  #describe 'self#field' do
  #
  #  let(:component_subclass) {
  #    Class.new(CapybaraPageObjects::Component) do
  #      field(:css_class) { source[:class] }
  #    end
  #  }
  #
  #  it 'returns the evaluated block' do
  #    component_subclass.new(find('.hidden', visible: false)).css_class.should eq('hidden')
  #  end
  #
  #end
  #
  ## --------------------
  #describe '#id' do
  #
  #  it 'returns the component ID if there is one' do
  #    new_component('.id-spec-with').id.should eq('id_spec')
  #  end
  #
  #  it 'returns nil for the component ID if there is none' do
  #    new_component('.id-spec-without').id.should be_nil
  #  end
  #
  #end
  #
  ## --------------------
  #describe '#css' do
  #
  #  it 'returns the component CSS class if there is one' do
  #    new_component('#css_spec_with').css.should eq('css-spec-with')
  #  end
  #
  #  it 'returns nil for the component ID if there is none' do
  #    new_component('#css_spec_without').css.should be_nil
  #  end
  #
  #end
  #
  ## --------------------
  #describe '#has_css?' do
  #
  #  context 'when the component has no CSS class' do
  #    let(:component) { new_component('#has_css_spec_1') }
  #
  #    it 'returns false' do
  #      component.should_not have_css('css1')
  #    end
  #  end
  #
  #  context 'when the component has 1 CSS class' do
  #    let(:component) { new_component('#has_css_spec_2') }
  #
  #    it 'returns false for a different CSS class' do
  #      component.should_not have_css('css9')
  #    end
  #
  #    it 'returns true for a matching CSS class' do
  #      component.should have_css('css1')
  #    end
  #  end
  #
  #  context 'when the component has 2 CSS classes' do
  #    let(:component) { new_component('#has_css_spec_3') }
  #
  #    it 'returns false for a different CSS class' do
  #      component.should_not have_css('css9')
  #    end
  #
  #    it 'returns true for a matching CSS class' do
  #      component.should have_css('css1')
  #    end
  #
  #    it 'returns true for 2 matching CSS classes in order' do
  #      component.should have_css('css1', 'css2')
  #    end
  #
  #    it 'returns true for 2 matching CSS classes in disorder' do
  #      component.should have_css('css2', 'css1')
  #    end
  #
  #    it 'returns false for one matching and one different CSS classes' do
  #      component.should_not have_css('css1', 'css9')
  #    end
  #  end
  #
  #end
  #
  ## --------------------
  #describe '#visible?' do
  #
  #  it 'returns true for a visible component' do
  #    new_component('.visible').should be_visible
  #  end
  #
  #  it 'returns false for a hidden component' do
  #    new_component('.hidden', visible: false).should_not be_visible
  #  end
  #
  #end
  #
  ## --------------------
  #describe '#hidden?' do
  #
  #  it 'returns true for a hidden component' do
  #    new_component('.hidden', visible: false).should be_hidden
  #  end
  #
  #  it 'returns false for a visible component' do
  #    new_component('.visible').should_not be_hidden
  #  end
  #
  #end
  #
  #
  ## ----------------------------------------------------------------------------------------------- helper methods -----
  #
  #def new_component_class
  #  Class.new(CapybaraPageObjects::Component)
  #end
  #
  #def new_component(*args)
  #  new_component_class.new(find(*args))
  #end

end
