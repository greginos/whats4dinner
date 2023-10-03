require 'jsonl'

file = File.join(Rails.root, 'db','seeds','recipes-fr.json')
source = File.read(file)
datas = JSONL.parse(source, object_class: OpenStruct)
datas.each do | data|
  recipe_data = data.each_pair
  recipe = Recipe.new(recipe_data.to_h)
  recipe.rate = recipe.rate.to_f
  recipe.nb_comments = recipe.nb_comments.to_i
  recipe.flat_ingredients = recipe.ingredients.join(',')
  recipe.save
end