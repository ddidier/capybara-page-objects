# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_page'

describe CapybaraPageObjects::Page do

  let(:page_class) { CapybaraPageObjects::Page }

  # --------------------
  it_behaves_like 'a CapybaraPageObjects::Page' do
    let(:page_path) { '/page' }
    let(:current_path) { '/page' }
  end

  # ====================================================================================================================
  # !!! Think about subclasses !!!
  # Portions of code have been copied because it was too difficult to share them....
  # There is at least: localized_page_spec
  # ====================================================================================================================

  # --------------------
  describe 'Page#path' do

    it 'is a mandatory DSL call' do
      expect { page_class.new }.to raise_error(CapybaraPageObjects::Page::MissingPathError,
                                               "Undefined raw path: use 'Page#path'")
    end

    it 'provides a DSL to set the raw path' do
      new_page('/page').send(:raw_path).should eq('/page')
    end

  end


  # ---------------------------------------------------------------------------------------------- without segment -----

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

    describe 'Page#visit' do
      before { Capybara.current_session.should_receive(:visit).with(expected_path) }

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

end
