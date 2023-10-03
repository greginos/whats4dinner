class RecipesController < ApplicationController
  before_action :validate_search_params, only: :search
  def index
    @recipes = []
    @query = []
    Recipes::Finder.call(filters:recipes_parameters)
    @query = recipes_parameters[:ingredients]
    @recipes = command.result
  end

  def show
    @recipe = Recipe.find(params[:id])
    render :show
  end

  private

  def recipes_parameters
    params.permit(:ingredients, :commit)
  end

  def validate_search_params
    head :bad_request unless recipes_parameters[:ingredients].compact_blank.any?
  end
end
