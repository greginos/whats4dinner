# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipes::Finder do
  subject(:find_recipes) { described_class.call(filters: filters) }

  let(:filters) { { ingredients: ingredients }  }
  let(:ingredients) { 'tomate fromage' }
  let!(:recipe_tomato) { Recipe.create(ingredients: ['2 tomates  fromage râpé 1 pomme de terre'], rate: 5.0) }

  context 'when the pg scope returns recipes' do
    before do
      allow(Recipe).to receive(:search_by_ingredients).and_return([recipe_tomato])
    end

    it { is_expected.to be_success }

    it 'returns the recipes' do
      expect(find_recipes.result).to eq([recipe_tomato])
    end
  end

  context 'when the pg scope returns no recipes' do
    before do
      allow(Recipe).to receive(:search_by_ingredients).and_return([], [recipe_tomato])
      allow(Recipe).to receive(:iterate_on_ingredients).and_call_original
    end

    context 'when there is only one ingredient' do
      let(:ingredients) { 'tomate' }

      it 'does not call the iterate on ingredients method' do
        find_recipes
        expect(Recipe).to have_received(:search_by_ingredients).once
      end
    end

    context 'when there are multiple ingredients' do
      let(:ingredients) { 'tomate fromage' }

      it 'calls the iterate on ingredients method' do
        find_recipes
        expect(Recipe).to have_received(:search_by_ingredients).exactly(4).times
      end
    end
  end
end
