class RecipesController < ApplicationController
  def index
    @recipes = []
    @query = []
    if params[:ingredients]
      command = Recipes::Finder.call(filters: recipe_params.slice(:ingredients).to_h)
      @query = params[:ingredients]
      @recipes = command.result if command.success?
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    render :show
  end

  private
  def recipe_params
    params.permit(:ingredients, :commit)
  end
end
