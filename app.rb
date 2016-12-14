require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require('ingredient')
require('recipe')
require('tag')

get('/') do
  erb(:index)
end
