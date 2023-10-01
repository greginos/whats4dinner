class RecipesController < ApplicationController
  before_action :validate_search_params, only: :search
  def index
    @recipes = []
    command = Recipes::Finder.call(filters:recipes_parameters)
    return render(status: :not_found) unless command.success?
    @recipes = command.result #.paginate(:page => params[:page]).order('id DESC')
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
