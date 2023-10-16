# frozen_string_literal: true

module Recipes
  class Finder

    NUMBER_OF_RECIPES_TO_RETURN = 25
    def initialize(filters:)
      @filters = filters
      @ingredients = filters[:ingredients]&.gsub('-','!')
    end

    def self.call(filters:)
      new(filters:).call
    end

    def call
      result = Recipe.search_by_ingredients(@ingredients).first(NUMBER_OF_RECIPES_TO_RETURN)
      if result.empty? && @ingredients.split.size > 1
        result = Recipe.iterate_on_ingredients(@ingredients, NUMBER_OF_RECIPES_TO_RETURN)
      end
      success = result.present?

      OpenStruct.new(result: result, success?: success)
    end
  end
end
