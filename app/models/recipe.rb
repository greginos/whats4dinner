class Recipe < ApplicationRecord
  include PgSearch::Model
  # self.per_page = 10
  pg_search_scope(:search_by_ingredients,
                  against: {
                    name: "A",
                    ingredients: "B",
                  },
                  ignoring: :accents,
                  :order_within_rank => "rate DESC")
end