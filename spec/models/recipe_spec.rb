# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipe', type: :model do
  describe '#search_by_ingredients' do
    subject(:search) { Recipe.search_by_ingredients(ingredients) }

    let!(:recipe_tomato) { Recipe.create(ingredients: ['2 tomates  fromage râpé 1 pomme de terre'], rate: 5.0) }
    let!(:recipe_cheese) { Recipe.create(ingredients: ['fromage râpé 1 pomme de terre'], rate: 5.0) }
    let!(:recipe_tomato_potatoe) { Recipe.create(ingredients: ['2 tomates 1 pomme de terre'], rate: 5.0) }

    context 'when searching one ingredient' do
      let(:ingredients) { 'tomate' }
      it 'returns the right recipes' do
        expect(search).to match_array([recipe_tomato, recipe_tomato_potatoe])
      end
    end

    context 'when searching multiple ingredient' do
      context 'when adding ingredients' do
        let(:ingredients) { 'tomate fromage' }

        it 'returns the right recipes' do
          expect(search).to match_array([recipe_tomato])
        end
      end

      context 'when removing ingredients' do
        let(:ingredients) { 'tomate !fromage' }

        it 'returns the right recipes' do
          expect(search).to match_array([recipe_tomato_potatoe])
        end
      end

      context 'when two recipes have the same ingredients' do
        let(:ingredients) { 'tomate' }
        let!(:recipe_tomato_low) { Recipe.create(ingredients: ['2 tomates  fromage râpé 1 pomme de terre'], rate: 4.7) }

        it 'returns the highest rating first' do
          expect(search).to eq([recipe_tomato, recipe_tomato_potatoe, recipe_tomato_low])
        end
      end
    end
  end
end
