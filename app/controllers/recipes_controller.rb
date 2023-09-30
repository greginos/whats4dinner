class RecipesController < ApplicationController
  before_action :validate_search_params, only: :search
  def search
    command = Recipes::Finder.call(filters: recipes_parameters)
    return render(status: :not_found) unless command.success?

    render(status: :ok, body: command.result)
  end

  private

  def recipes_parameters
    params.require(:recipes)
  end

  def validate_search_params
    head :bad_request unless recipes_parameters[:ingredients].compact_blank.any?
  end
end
