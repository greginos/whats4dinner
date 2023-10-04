# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  subject(:search_recipes) { get(:index, params: params) }

  let(:params) { { ingredients: ingredients, commit: 'search' } }
  let(:recipes_finder) { instance_double(Recipes::Finder) }
  let(:recipes) { [] }

  before do
    allow(Recipes::Finder).to receive(:new).and_return(recipes_finder)
  end

  context 'when there are ingredients' do
    let(:ingredients) { 'tomato' }
    before do
      allow(recipes_finder).to receive(:call).and_return(struct_response)
    end

    let(:struct_response) { OpenStruct.new(result: recipes, success?: true, errors: []) }

    it 'calls the recipe finder' do
      search_recipes
      expect(Recipes::Finder).to have_received(:new).with(filters: {ingredients: ingredients}).once
    end

    context 'when the recipes finder returns recipes' do
      it 'renders the recipes' do
        search_recipes
        expect(response).to have_http_status(:ok)
      end
    end
  end

  context 'when there are no ingredients' do
    let(:ingredients) { [] }

    it 'does not call the recipe finder' do
      search_recipes
      expect(Recipes::Finder).not_to have_received(:new)
    end
  end
end
