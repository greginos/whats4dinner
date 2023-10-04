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
end