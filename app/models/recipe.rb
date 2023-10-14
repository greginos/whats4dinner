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
    list_to_query = ingredients_list.combination(ingredients_list.length - 1).to_a
    hash_count = {}
    list_to_query.each do |ingredients|
      hash_count[ingredients] = Recipe.search_by_ingredients(ingredients).count
    end
    Recipe.search_by_ingredients(hash_count.key(hash_count.values.max)).first(number)
  end
end