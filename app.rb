require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require('./lib/ingredient')
require('./lib/recipe')
require('./lib/tag')

get('/') do
  @recipes = Recipe.all
  erb(:index)
end

post('/recipes') do
  Recipe.create({
    :name => params.fetch('new-recipe-name'),
    :instruction => params.fetch('new-recipe-instruction')
  })
  redirect '/'
end
