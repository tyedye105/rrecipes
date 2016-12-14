require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require('./lib/ingredient')
require('./lib/recipe')
require('./lib/tag')

get '/' do
  @recipes = Recipe.all
  erb(:index)
end

get '/recipes/:id' do
  @recipe = Recipe.find(params.fetch('id').to_i)
  erb(:recipe_detail)
end

post '/recipes' do
  Recipe.create({
    :name => params.fetch('new-recipe-name'),
    :instruction => params.fetch('new-recipe-instruction')
  })
  redirect '/'
end

patch '/recipes/:id' do
  recipe = Recipe.find(params.fetch('id').to_i)
  update_name = params.fetch('update-recipe-name')
  update_instruction = params.fetch('update-recipe-instruction')
  recipe.update({:name => update_name, :instruction => update_instruction})
  redirect "/recipes/#{recipe.id}"
end

delete '/recipes/:id' do
  to_delete = params.fetch("id").to_i
  Recipe.find(to_delete).destroy
  redirect '/'
end

post '/ingredients' do
  recipe_id = params.fetch('recipe-id').to_i
  ingredient = Ingredient.create({
    :name => params.fetch('new-ingredient-name'),
    :amount => params.fetch('new-ingredient-amount')
  })
  Recipe.find(recipe_id).ingredients.push(ingredient)
  redirect "/recipes/#{recipe_id}"
end

delete '/ingredients/:id' do
  Ingredient.find(params.fetch('id').to_i).destroy
  redirect "/recipes/#{params.fetch('recipe-id')}"
end
