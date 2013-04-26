# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'capybara-page-objects/shared_examples_for_node'

describe CapybaraPageObjects::Elements::Meta do

  # ------------------------------------------------------------------------------------------------ Node examples -----

  # Meta is a Node but not a Component
  it_behaves_like 'a CapybaraPageObjects::Node' do
    let(:node_class) { CapybaraPageObjects::Elements::Anchor }
  end


  # --------------------------------------------------------------------------------------------- Element examples -----

  before { visit '/elements/meta' }

  # --------------------
  describe 'self#with_http_equiv' do
    let(:meta) { CapybaraPageObjects::Elements::Meta.with_http_equiv('meta_equiv') }

    it 'have a :http_equiv method' do
      meta.should respond_to(:http_equiv)
    end

    it 'have a :content method' do
      meta.should respond_to(:content)
    end

    it 'returns the meta http_equiv' do
      meta.http_equiv.should eq('meta_equiv')
    end

    it 'returns the meta content' do
      meta.content.should eq('meta_equiv_content')
    end

  end

  # --------------------
  describe 'self#with_name' do
    let(:meta) { CapybaraPageObjects::Elements::Meta.with_name('meta_name') }

    it 'have a :name method' do
      meta.should respond_to(:name)
    end

    it 'have a :content method' do
      meta.should respond_to(:content)
    end

    it 'returns the meta name' do
      meta.name.should eq('meta_name')
    end

    it 'returns the meta content' do
      meta.content.should eq('meta_name_content')
    end
  end

  # --------------------
  describe 'self#charset' do
    let(:meta) { CapybaraPageObjects::Elements::Meta.charset }

    it 'have a :charset method' do
      meta.should respond_to(:charset)
    end

    it 'returns the meta charset' do
      meta.charset.should eq('my charset')
    end
  end

  # --------------------
  describe 'self#content_language' do
    let(:meta) { CapybaraPageObjects::Elements::Meta.content_language }

    it 'have a :http_equiv method' do
      meta.should respond_to(:http_equiv)
    end

    it 'have a :content method' do
      meta.should respond_to(:content)
    end

    it 'returns the meta http_equiv' do
      meta.http_equiv.should eq('Content-Language')
    end

    it 'returns the meta content' do
      meta.content.should eq('my language')
    end

  end

  # --------------------
  describe 'self#content_type' do
    let(:meta) { CapybaraPageObjects::Elements::Meta.content_type }

    it 'have a :http_equiv method' do
      meta.should respond_to(:http_equiv)
    end

    it 'have a :content method' do
      meta.should respond_to(:content)
    end

    it 'returns the meta http_equiv' do
      meta.http_equiv.should eq('Content-Type')
    end

    it 'returns the meta content' do
      meta.content.should eq('my type')
    end

  end

  # --------------------
  describe 'self#author' do
    let(:meta) { CapybaraPageObjects::Elements::Meta.author }

    it 'have a :name method' do
      meta.should respond_to(:name)
    end

    it 'have a :content method' do
      meta.should respond_to(:content)
    end

    it 'returns the meta name' do
      meta.name.should eq('author')
    end

    it 'returns the meta content' do
      meta.content.should eq('my author')
    end
  end

  # --------------------
  describe 'self#copyright' do
    let(:meta) { CapybaraPageObjects::Elements::Meta.copyright }

    it 'have a :name method' do
      meta.should respond_to(:name)
    end

    it 'have a :content method' do
      meta.should respond_to(:content)
    end

    it 'returns the meta name' do
      meta.name.should eq('copyright')
    end

    it 'returns the meta content' do
      meta.content.should eq('my copyright')
    end
  end

  # --------------------
  describe 'self#description' do
    let(:meta) { CapybaraPageObjects::Elements::Meta.description }

    it 'have a :name method' do
      meta.should respond_to(:name)
    end

    it 'have a :content method' do
      meta.should respond_to(:content)
    end

    it 'returns the meta name' do
      meta.name.should eq('description')
    end

    it 'returns the meta content' do
      meta.content.should eq('my description')
    end
  end

  # --------------------
  describe 'self#keywords' do
    let(:meta) { CapybaraPageObjects::Elements::Meta.keywords }

    it 'have a :name method' do
      meta.should respond_to(:name)
    end

    it 'have a :content method' do
      meta.should respond_to(:content)
    end

    it 'returns the meta name' do
      meta.name.should eq('keywords')
    end

    it 'returns the meta content' do
      meta.content.should eq('my keywords')
    end
  end

end
