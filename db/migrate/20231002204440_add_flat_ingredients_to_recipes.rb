class AddFlatIngredientsToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :flat_ingredients, :string
  end
end
