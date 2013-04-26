# -*- encoding : utf-8 -*-
require 'spec_helper'

#
# @param [Class] node_class the actual class of the node
#
shared_examples 'a CapybaraPageObjects::Node' do

  let(:node_instance) { node_class.new }

  # --------------------
  %w(all find find_by_id find_link find_button find_field first).each do |finder_name|
    describe "##{finder_name}" do

      it 'is delegated to source' do
        node_instance.source.should_receive(finder_name).with('some_arguments')
        node_instance.send(finder_name, 'some_arguments')
      end

      it 'is protected' do
        node_instance.protected_methods.should include(finder_name.to_sym)
      end

    end
  end


  # --------------------------------------------------------------------------------------------------------------------
  # @param node_component the component instance as retrieved by the created method
  shared_examples_for 'private examples for CapybaraPageObjects::Node#component' do

    it 'creates a component of the specified type' do
      node_component.should be_kind_of (node_component_class)
    end

    it 'creates a component wrapping the specified tag' do
      node_component.source[:id].should eq('my_node')
    end

  end


  # --------------------------------------------------------------------------------------------------------------------
  describe 'self#component' do

    # --------------------
    before { visit '/node' }
    let(:node_component_class) { NodeImpl }
    let(:node_component) { node_subclass.new.node_component }

    # --------------------
    context 'when using a finder' do

      let(:node_subclass) {
        Class.new(node_class) do
          component(:node_component) { NodeImpl.new(find('#my_node')) }
        end
      }

      include_examples 'private examples for CapybaraPageObjects::Node#component'
    end

    # --------------------
    context 'when using a selector' do

      let(:node_subclass) {
        Class.new(node_class) do
          component :node_component, NodeImpl, '#my_node'
        end
      }

      include_examples 'private examples for CapybaraPageObjects::Node#component'
    end

    # --------------------
    context 'when using a css selector' do

      let(:node_subclass) {
        Class.new(node_class) do
          component :node_component, NodeImpl, '#my_node', :css
        end
      }

      include_examples 'private examples for CapybaraPageObjects::Node#component'
    end

    # --------------------
    context 'when using a xpath selector' do

      let(:node_subclass) {
        Class.new(node_class) do
          component :node_component, NodeImpl, '/html/body/div', :xpath
        end
      }

      include_examples 'private examples for CapybaraPageObjects::Node#component'
    end

    # --------------------
    context 'when using a block with arguments' do

      it 'raises an ArgumentError' do
        expect {
          Class.new(node_class) do
            component(:node_component, :some_argument) { NodeImpl.new(find('#my_node')) }
          end
        }.to raise_error ArgumentError, /usage/
      end

    end

    # --------------------
    context 'when using less than 2 arguments' do

      it 'raises an ArgumentError' do
        expect {
          Class.new(node_class) do
            component :node_component, :argument_1
          end
        }.to raise_error ArgumentError, /usage/
      end

    end

    # --------------------
    context 'when using more than 3 arguments' do

      it 'raises an ArgumentError' do
        expect {
          Class.new(node_class) do
            component :node_component, :argument_1, :argument_2, :argument_3, :argument_4
          end
        }.to raise_error ArgumentError, /usage/
      end

    end

    # --------------------
    context 'when using an invalid selector' do

      around do |example|
        with_no_wait_time { example.run }
      end

      let(:node_subclass) {
        Class.new(node_class) do
          component :node_component, NodeImpl, '#invalid'
        end
      }

      it 'creates a CapybaraPageObjects::None' do
        node_component.should be_kind_of CapybaraPageObjects::None
        node_component.locator.should eq('#invalid')
        node_component.selector.should eq(:css)
      end

    end

  end

  # --------------------------------------------------------------------------------------------------------------------
  describe 'self#register_component' do

    before { visit '/node' }
    let(:node_subclass) { new_node_subclass(node_class) }
    let(:component_class) { new_node_subclass(CapybaraPageObjects::Node, 'MyComponent') }

    # --------------------
    context 'when not specifying a name' do
      before { node_subclass.register_component component_class }

      it 'creates a class method named with the underscored name of the class' do
        node_subclass.methods.should include(:my_component)
      end

      include_examples 'private examples for CapybaraPageObjects::Node#component' do
        before { node_subclass.my_component :node_component, '#my_node', :css }
        let(:node_component_class) { component_class }
        let(:node_component) { node_subclass.new.node_component }
      end

    end

    # --------------------
    context 'when specifying a name' do
      before { node_subclass.register_component component_class, :my_other_component }

      it 'creates a class method with the specified name' do
        node_subclass.methods.should include(:my_other_component)
      end

      include_examples 'private examples for CapybaraPageObjects::Node#component' do
        before { node_subclass.my_other_component :node_component, '#my_node', :css }
        let(:node_component_class) { component_class }
        let(:node_component) { node_subclass.new.node_component }
      end

    end

  end


  # ----------------------------------------------------------------------------------------------- helper methods -----

  def new_node_subclass(node_class, node_class_name = nil)
    Class.new(node_class).tap do |klass|
      if node_class_name
        Object.send(:remove_const, node_class_name) if Object.const_defined?(node_class_name)
        Object.const_set(node_class_name, klass)
      end
    end
  end

  class NodeImpl < CapybaraPageObjects::Node
  end

end
