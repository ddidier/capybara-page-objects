# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_node'

#
# @param [Class] page_class the actual class of the page
#
shared_examples 'a CapybaraPageObjects::Page' do

  # ------------------------------------------------------------------------------------------------ Node examples -----

  it_behaves_like 'a CapybaraPageObjects::Node' do
    let(:node_class) { new_page_class('/some/path') }
  end

  # --------------------
  describe '#source' do
    let(:node_instance) { new_page_class('/page').new(source) }

    # --------------------
    context 'when source is specified' do
      let(:source) { mock }

      it 'returns the specified source' do
        node_instance.source.should eq(Capybara.current_session)
      end
    end

    # --------------------
    context 'when source is not specified' do
      let(:source) { nil }

      it 'returns the Capybara current session' do
        node_instance.source.should eq(Capybara.current_session)
      end
    end

  end


  # ------------------------------------------------------------------------------------------------ Page examples -----

  # --------------------
  describe '#title' do
    it 'returns the title of the page' do
      visit_new_page('/page').title.should eq('DummyPage tests support')
    end
  end

  # --------------------
  describe '#current_path' do
    it 'returns the current actual path of the page' do
      visit_new_page('/page').current_path.should eq('/page')
    end
  end

  # --------------------
  describe '#current_url' do
    it 'returns the current actual URL of the page' do
      visit_new_page('/page').current_url.should eq('http://www.example.com/page')
    end
  end

  # --------------------
  describe 'Page#path' do

    it 'is a mandatory DSL call' do
      expect { CapybaraPageObjects::Page.new }.to raise_error(CapybaraPageObjects::Page::MissingPathError,
                                                              "Undefined raw path: use 'Page#path'")
    end

    it 'provides a DSL to set the raw path' do
      new_page('/page').send(:raw_path).should eq('/page')
    end

  end


  # ---------------------------------------------------------------------------------------------- without segment -----

  # @param session
  # @param page_class
  # @param page_instance
  # @param page_parameters
  # @param expected_path_ids
  # @param expected_path_parameters
  # @param expected_query_parameters
  # @param expected_path
  shared_examples_for 'private examples for CapybaraPageObjects::Page' do

    describe '#path_ids' do
      it 'returns the path IDs' do
        page_instance.path_ids.should eq(expected_path_ids)
      end
    end

    describe '#path_parameters' do
      it 'returns the path parameters' do
        page_instance.path_parameters.should eq(expected_path_parameters)
      end
    end

    describe '#query_parameters' do
      it 'returns the query parameters' do
        page_instance.query_parameters.should eq(expected_query_parameters)
      end
    end

    describe '#path' do
      it 'returns the interpolated path' do
        page_instance.path.should eq(expected_path)
      end
    end

    describe '#session' do
      it 'returns the current session' do
        page_instance.session.should eq(Capybara.current_session)
      end
    end

    describe '#displayed?' do
      it 'returns true if the interpolated path is equal to the current path' do
        session.should_receive(:current_path).and_return(expected_path)
        page_instance.should be_displayed
      end

      it 'returns true if the interpolated path is equal to the current path with a trailing slash' do
        session.should_receive(:current_path).and_return(expected_path + '/')
        page_instance.should be_displayed
      end

      it 'returns true if the interpolated path is equal to the current path without a trailing slash' do
        session.should_receive(:current_path).and_return(expected_path)
        page_instance.should_receive(:path).and_return(expected_path + '/')
        page_instance.should be_displayed
      end

      it 'returns false if the interpolated path is not equal to the current path' do
        session.should_receive(:current_path).and_return('/another_path')
        page_instance.should_not be_displayed
      end

      it 'returns true if both paths are root' do
        session.should_receive(:current_path).and_return('/')
        page_instance.should_receive(:path).and_return('/')
        page_instance.should be_displayed
      end
    end

    describe '#visit' do
      before { session.should_receive(:visit).with(expected_path) }

      it 'visits the specified path' do
        page_instance.visit
      end
    end

    describe 'Page#visit' do
      before { session.should_receive(:visit).with(expected_path) }

      it 'visits the specified path' do
        page_subclass.visit(page_parameters).path.should eq(expected_path)
      end

      it 'returns the page instance' do
        page_subclass.visit(page_parameters).should be_kind_of(page_subclass)
      end
    end

  end


  # --------------------
  context 'when the path has no segment' do

    let(:session) { mock }
    let(:another_session) { mock }
    before { Capybara.stub(:current_session).and_return(session) }

    let(:page_path) { '/some/path' }
    let(:page_subclass) { new_page_class(page_path) }
    let(:page_instance) { page_subclass.new(page_parameters) }

    # --------------------
    context 'and no query parameter is specified' do
      let(:expected_path_ids) { Array.new }
      let(:expected_path_parameters) { Hash.new }
      let(:expected_query_parameters) { Hash.new }
      let(:expected_path) { '/some/path' }

      # --------------------
      context 'with explicit path parameters and explicit query parameters' do
        let(:path_parameters) { Hash.new }
        let(:query_parameters) { Hash.new }
        let(:page_parameters) { Hash[path_parameters: path_parameters, query_parameters: query_parameters] }

        include_examples 'private examples for CapybaraPageObjects::Page'
      end

      # --------------------
      context 'with implicit path parameters and explicit query parameters' do
        let(:path_parameters) { nil }
        let(:query_parameters) { Hash.new }
        let(:page_parameters) { Hash[query_parameters: query_parameters] }

        include_examples 'private examples for CapybaraPageObjects::Page'
      end

      # --------------------
      context 'with explicit path parameters and implicit query parameters' do
        let(:path_parameters) { Hash.new }
        let(:query_parameters) { nil }
        let(:page_parameters) { Hash[path_parameters: path_parameters] }

        include_examples 'private examples for CapybaraPageObjects::Page'
      end

      # --------------------
      context 'with implicit path parameters and implicit query parameters' do
        let(:path_parameters) { nil }
        let(:query_parameters) { nil }
        let(:page_parameters) { nil }

        include_examples 'private examples for CapybaraPageObjects::Page'
      end

    end # and no parameter is specified

    # --------------------
    context 'and query parameters are specified' do
      let(:expected_path_ids) { Array.new }
      let(:expected_path_parameters) { Hash.new }
      let(:expected_query_parameters) { query_parameters }
      let(:expected_path) { '/some/path?q1=1&q2=v2' }

      # --------------------
      context 'with explicit path parameters and explicit query parameters' do
        let(:path_parameters) { Hash.new }
        let(:query_parameters) { Hash[q1: 1, q2: 'v2'] }
        let(:page_parameters) { Hash[path_parameters: path_parameters, query_parameters: query_parameters] }

        include_examples 'private examples for CapybaraPageObjects::Page'
      end

      # --------------------
      context 'with implicit path parameters and explicit query parameters' do
        let(:path_parameters) { nil }
        let(:query_parameters) { Hash[q1: 1, q2: 'v2'] }
        let(:page_parameters) { Hash[query_parameters: query_parameters] }

        include_examples 'private examples for CapybaraPageObjects::Page'
      end

      # --------------------
      context 'with explicit path parameters and implicit query parameters' do
        let(:path_parameters) { nil }
        let(:query_parameters) { Hash[q1: 1, q2: 'v2'] }
        let(:page_parameters) { Hash[path_parameters: path_parameters].merge(query_parameters) }

        include_examples 'private examples for CapybaraPageObjects::Page'
      end

      # --------------------
      context 'with implicit path parameters and implicit query parameters' do
        let(:path_parameters) { nil }
        let(:query_parameters) { Hash[q1: 1, q2: 'v2'] }
        let(:page_parameters) { query_parameters }

        include_examples 'private examples for CapybaraPageObjects::Page'
      end

    end # and query parameters are specified

  end # when the path has no segment


  # ------------------------------------------------------------------------------------------------ with segments -----

  context 'when the path has segments' do

    let(:session) { mock }
    let(:another_session) { mock }
    before { Capybara.stub(:current_session).and_return(session) }

    let(:page_path) { '/some/:p1/segmented/:p2/path' }
    let(:page_subclass) { new_page_class(page_path) }
    let(:page_instance) { page_subclass.new(page_parameters) }

    # --------------------
    context 'and all segment parameters are missing' do
      it 'raises a MissingPathSegment error on creation' do
        expect { page_subclass.new }.to raise_error(CapybaraPageObjects::Page::MissingPathSegmentError,
                                                    'Undefined path segment(s): p1, p2')
      end
    end

    # --------------------
    context 'and one segment parameters is missing' do
      it 'raises a MissingPathSegment error on creation' do
        expect { page_subclass.new(Hash[p1: 1]) }.to raise_error(CapybaraPageObjects::Page::MissingPathSegmentError,
                                                                 'Undefined path segment(s): p2')
      end
    end

    # --------------------
    context 'and all segment parameters are specified' do
      let(:path_parameters) { Hash[p1: 1, p2: 'v2'] }

      let(:expected_path_ids) { Array[:p1, :p2] }
      let(:expected_path_parameters) { path_parameters }
      let(:expected_query_parameters) { query_parameters }

      # --------------------
      context 'and no query parameter is specified' do
        let(:query_parameters) { Hash.new }
        let(:expected_path) { '/some/1/segmented/v2/path' }

        context 'with explicit path parameters and explicit query parameters' do
          let(:page_parameters) { Hash[path_parameters: path_parameters, query_parameters: query_parameters] }
          include_examples 'private examples for CapybaraPageObjects::Page'
        end

        context 'with implicit path parameters and explicit query parameters' do
          let(:page_parameters) { Hash[query_parameters: query_parameters].merge(path_parameters) }
          include_examples 'private examples for CapybaraPageObjects::Page'
        end

        context 'with explicit path parameters and implicit query parameters' do
          let(:page_parameters) { Hash[path_parameters: path_parameters].merge(query_parameters) }
          include_examples 'private examples for CapybaraPageObjects::Page'
        end

        context 'with implicit path parameters and implicit query parameters' do
          let(:page_parameters) { path_parameters.merge(query_parameters) }
          include_examples 'private examples for CapybaraPageObjects::Page'
        end

      end

      # --------------------
      context 'and query parameters are specified' do
        let(:query_parameters) { Hash[q3: 'v3', q4: 'v4'] }
        let(:expected_path) { '/some/1/segmented/v2/path?q3=v3&q4=v4' }

        context 'with explicit path parameters and explicit query parameters' do
          let(:page_parameters) { Hash[path_parameters: path_parameters, query_parameters: query_parameters] }
          include_examples 'private examples for CapybaraPageObjects::Page'
        end

        context 'with implicit path parameters and explicit query parameters' do
          let(:page_parameters) { Hash[query_parameters: query_parameters].merge(path_parameters) }
          include_examples 'private examples for CapybaraPageObjects::Page'
        end

        context 'with explicit path parameters and implicit query parameters' do
          let(:page_parameters) { Hash[path_parameters: path_parameters].merge(query_parameters) }
          include_examples 'private examples for CapybaraPageObjects::Page'
        end

        context 'with implicit path parameters and implicit query parameters' do
          let(:page_parameters) { path_parameters.merge(query_parameters) }
          include_examples 'private examples for CapybaraPageObjects::Page'
        end

      end

    end # and all segment parameters are specified

  end # when the path has segments


  # ----------------------------------------------------------------------------------------------- helper methods -----

  def new_page_class(path)
    Class.new(page_class) do
      self.path(path)
    end
  end

  def new_page(path, *args)
    new_page_class(path).new(*args)
  end

  def visit_new_page(path, *args)
    new_page(path, *args).tap { |page| page.visit }
  end

end
