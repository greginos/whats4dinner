class Recipe < ApplicationRecord
  include PgSearch::Model
  pg_search_scope(:search_by_ingredients,
                  against: {
                    name: "A",
                    ingredients: "B",
                  },
                  using: { tsearch: {
                    dictionary: 'french',
                    tsvector_column: "tsv",
                    negation: true
                  }
                  },
                  ignoring: :accents,
                  :order_within_rank => "rate DESC")

  before_create :fill_flat_ingredients

  def fill_flat_ingredients
    self.flat_ingredients = ingredients
  end

  def self.iterate_on_ingredients(ingredients, number)
    ingredients_list = ingredients.split(' ')
    querying_list = ingredients_list.combination(ingredients_list.length - 1).to_a

    found_recipes_count = {}
    querying_list.each do |ingredients|
      found_recipes_count[ingredients] = Recipe.search_by_ingredients(ingredients).count
    end

    highest_recipes_combination = found_recipes_count.key(found_recipes_count.values.max)
    Recipe.search_by_ingredients(highest_recipes_combination).first(number)
  end
end