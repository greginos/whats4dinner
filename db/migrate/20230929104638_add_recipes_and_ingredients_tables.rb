class AddRecipesAndIngredientsTables < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :unit
      t.integer :quantity
      t.timestamps
    end
    create_table :recipes do |t|
      t.string :name
      t.timestamps
    end
  end
end
