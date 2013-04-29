# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_page'

describe CapybaraPageObjects::LocalizedPage do

  around(:each) do |example|
    with_page_object_class(CapybaraPageObjects::LocalizedPage) do
      example.run
    end
  end

  # ------------------------------------------------------------------------------------------------ Page examples -----

  let(:page_class) { CapybaraPageObjects::LocalizedPage }

  # --------------------
  it_behaves_like 'a CapybaraPageObjects::Page' do
    let(:page_path) { '/localized_page' }
    let(:current_path) { '/en/localized_page' }
  end

  # --------------------
  describe 'Page#path' do

    it 'is a mandatory DSL call' do
      expect { CapybaraPageObjects::LocalizedPage.new }.to raise_error(CapybaraPageObjects::Page::MissingPathError,
                                                                       "Undefined raw path: use 'Page#path'")
    end

    context 'when the path has no leading slash' do
      it 'prepends :locale to the specified path' do
        new_page('localized_page').send(:raw_path).should eq('/:locale/localized_page')
      end
    end

    context 'when the path has a leading slash' do
      it 'prepends :locale to the specified path' do
        new_page('/localized_page').send(:raw_path).should eq('/:locale/localized_page')
      end
    end

  end


  # -------------------------------------------------------------------------------------- Localized Page examples -----

  # @param session
  # @param page_class
  # @param page_instance
  # @param page_parameters
  # @param expected_path_ids
  # @param expected_path_parameters
  # @param expected_query_parameters
  # @param expected_path
  shared_examples_for 'private examples for CapybaraPageObjects::LocalizedPage' do

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

    describe '#locale' do
      it 'returns the locale' do
        page_instance.locale.should eq(expected_locale)
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


  # --------------------------------------------------------------------------------------------------------------------

  #
  # @param locale_parameter
  # @param expected_locale
  #
  shared_examples_for 'private contexts for CapybaraPageObjects::LocalizedPage' do

    # -------------------------------------------------- without segment
    context 'when the path has no segment' do

      let(:page_path) { '/some/path' }
      let(:page_subclass) { new_page_class(page_path) }
      let(:page_instance) { page_subclass.new(page_parameters) }

      # --------------------
      context 'and no query parameter is specified' do
        let(:expected_path_ids) { Array[:locale] }
        let(:expected_path_parameters) { Hash[locale: expected_locale] }
        let(:expected_query_parameters) { Hash.new }
        let(:expected_path) { "/#{expected_locale}/some/path" }

        # --------------------
        context 'with explicit path parameters and explicit query parameters' do
          let(:path_parameters) { Hash.new }
          let(:query_parameters) { Hash.new }
          let(:page_parameters) { Hash[path_parameters: path_parameters.merge(locale_parameter), query_parameters: query_parameters] }

          include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
        end

        # --------------------
        context 'with implicit path parameters and explicit query parameters' do
          let(:path_parameters) { nil }
          let(:query_parameters) { Hash.new }
          let(:page_parameters) { Hash[query_parameters: query_parameters].merge(locale_parameter) }

          include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
        end

        # --------------------
        context 'with explicit path parameters and implicit query parameters' do
          let(:path_parameters) { Hash.new }
          let(:query_parameters) { nil }
          let(:page_parameters) { Hash[path_parameters: path_parameters.merge(locale_parameter)] }

          include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
        end

        # --------------------
        context 'with implicit path parameters and implicit query parameters' do
          let(:path_parameters) { nil }
          let(:query_parameters) { nil }
          let(:page_parameters) { nil_if_empty(locale_parameter) }

          include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
        end

      end # and no parameter is specified

      # --------------------
      context 'and query parameters are specified' do
        let(:expected_path_ids) { Array[:locale] }
        let(:expected_path_parameters) { Hash[locale: expected_locale] }
        let(:expected_query_parameters) { query_parameters }
        let(:expected_path) { "/#{expected_locale}/some/path?q1=1&q2=v2" }

        # --------------------
        context 'with explicit path parameters and explicit query parameters' do
          let(:path_parameters) { Hash.new }
          let(:query_parameters) { Hash[q1: 1, q2: 'v2'] }
          let(:page_parameters) { Hash[path_parameters: path_parameters.merge(locale_parameter), query_parameters: query_parameters] }

          include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
        end

        # --------------------
        context 'with implicit path parameters and explicit query parameters' do
          let(:path_parameters) { nil }
          let(:query_parameters) { Hash[q1: 1, q2: 'v2'] }
          let(:page_parameters) { Hash[query_parameters: query_parameters].merge(locale_parameter) }

          include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
        end

        # --------------------
        context 'with explicit path parameters and implicit query parameters' do
          let(:path_parameters) { nil }
          let(:query_parameters) { Hash[q1: 1, q2: 'v2'] }
          let(:page_parameters) { Hash[path_parameters: nil_if_empty(locale_parameter)].merge(query_parameters) }

          include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
        end

        # --------------------
        context 'with implicit path parameters and implicit query parameters' do
          let(:path_parameters) { nil }
          let(:query_parameters) { Hash[q1: 1, q2: 'v2'] }
          let(:page_parameters) { query_parameters.merge(locale_parameter) }

          include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
        end

      end # and query parameters are specified

    end # when the path has no segment


    # -------------------------------------------------- with segment
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
        let(:path_parameters) { Hash[p1: 1, p2: 'v2'].merge(locale_parameter) }

        let(:expected_path_ids) { Array[:locale, :p1, :p2] }
        let(:expected_path_parameters) { path_parameters.merge(Hash[locale: expected_locale]) }
        let(:expected_query_parameters) { query_parameters }

        # --------------------
        context 'and no query parameter is specified' do
          let(:query_parameters) { Hash.new }
          let(:expected_path) { "/#{expected_locale}/some/1/segmented/v2/path" }

          context 'with explicit path parameters and explicit query parameters' do
            let(:page_parameters) { Hash[path_parameters: path_parameters, query_parameters: query_parameters] }
            include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
          end

          context 'with implicit path parameters and explicit query parameters' do
            let(:page_parameters) { Hash[query_parameters: query_parameters].merge(path_parameters) }
            include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
          end

          context 'with explicit path parameters and implicit query parameters' do
            let(:page_parameters) { Hash[path_parameters: path_parameters].merge(query_parameters) }
            include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
          end

          context 'with implicit path parameters and implicit query parameters' do
            let(:page_parameters) { path_parameters.merge(query_parameters) }
            include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
          end

        end

        # --------------------
        context 'and query parameters are specified' do
          let(:query_parameters) { Hash[q3: 'v3', q4: 'v4'] }
          let(:expected_path) { "/#{expected_locale}/some/1/segmented/v2/path?q3=v3&q4=v4" }

          context 'with explicit path parameters and explicit query parameters' do
            let(:page_parameters) { Hash[path_parameters: path_parameters, query_parameters: query_parameters] }
            include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
          end

          context 'with implicit path parameters and explicit query parameters' do
            let(:page_parameters) { Hash[query_parameters: query_parameters].merge(path_parameters) }
            include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
          end

          context 'with explicit path parameters and implicit query parameters' do
            let(:page_parameters) { Hash[path_parameters: path_parameters].merge(query_parameters) }
            include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
          end

          context 'with implicit path parameters and implicit query parameters' do
            let(:page_parameters) { path_parameters.merge(query_parameters) }
            include_examples 'private examples for CapybaraPageObjects::LocalizedPage'
          end

        end

      end # and all segment parameters are specified

    end # when the path has segments

  end # private contexts for CapybaraPageObjects::LocalizedPage


  # --------------------------------------------------------------------------------------------------------------------

  before { CapybaraPageObjects::Configuration.reset }

  context 'when the default locale is not overriden by the instance' do
    include_examples 'private contexts for CapybaraPageObjects::LocalizedPage' do
      let(:expected_locale) { :en }
      let(:locale_parameter) { Hash.new }
    end
  end

  context 'when the default locale is overriden by the instance' do
    include_examples 'private contexts for CapybaraPageObjects::LocalizedPage' do
      let(:expected_locale) { :fr }
      let(:locale_parameter) { Hash[locale: :fr] }
    end
  end

  context 'when the default locale is overriden by the configuration' do
    before { CapybaraPageObjects::Configuration.default_locale = :fr }

    include_examples 'private contexts for CapybaraPageObjects::LocalizedPage' do
      let(:expected_locale) { :fr }
      let(:locale_parameter) { Hash.new }
    end
  end

end
