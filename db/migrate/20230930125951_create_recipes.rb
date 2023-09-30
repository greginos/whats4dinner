class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :ingredients, array: true, default: []
      t.float :rate
      t.text :image
      t.string :tags, array: true, default: []
      t.string :budget
      t.integer :nb_comments
      t.string :total_time
      t.string :difficulty
      t.string :author_tip
      t.string :prep_time
      t.string :cook_time
      t.string :author
      t.integer :people_quantity

      t.timestamps
    end
    add_index :recipes, :ingredients
    add_index :recipes, :rate
    add_index :recipes, :tags
    add_index :recipes, :difficulty
    add_index :recipes, :people_quantity
  end
end
