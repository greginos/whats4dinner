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
      result = nil
      success = false
      errors = []

      OpenStruct.new(result: result, success?: success, errors: errors)
    end
  end
end
