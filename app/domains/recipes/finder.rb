# frozen_string_literal: true

module Recipes
  class Finder

    def initialize(filters:)
      @filters = filters
      @ingredients = filters[:ingredients]
    end

    def self.call(filters:)
      new(filters:).call
    end

    def call
      errors = []

      result = Recipe.search_by_ingredients(@ingredients&.gsub('-','!')).first(25)
      success = result.present?

      OpenStruct.new(result: result, success?: success, errors: errors)
    end
  end
end
