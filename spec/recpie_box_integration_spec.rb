require('spec_helper')
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe "recipe box app", {:type => :feature} do
  describe "the view recipes path" do
    it 'will let the user see a list of recipes' do
      Recipe.create({:name => "Beef Wellington", :instruction => "has many"})
      visit '/'
      expect(page).to have_content "Beef Wellington"
    end
  end

  describe "the add recipes path" do
    it "will let the user add new recipes" do
      visit '/'
      fill_in('new-recipe-name', :with => 'Scrambled Eggs')
      fill_in('new-recipe-instruction', :with => 'few')
      click_button('Create Recipe')
      expect(page).to have_content "Scrambled Eggs"
    end
  end

  describe "the individual recipe view" do
    it "will let the user view the specifics of a specific recipe" do
      test_recipe = Recipe.create({:name => "Baja Skillet", :instruction => "has many"})
      visit "/recipes/#{test_recipe.id}"
      expect(page).to have_content "Baja Skillet"
    end

    it "shows a list of ingredients for the recipe" do
      test_recipe = Recipe.create({:name => "Baja Skillet", :instruction => "has many"})
      test_ingredient = Ingredient.create({:name => "Chicken", :amount => "uh. some."})
      test_recipe.ingredients.push(test_ingredient)
      visit "/recipes/#{test_recipe.id}"
      expect(page).to have_content "uh. some. Chicken"
    end

    it "shows a list of tags for the recipe" do

    end
  end

  describe "the update recipes path" do
    it "will let the user update a recipe" do
      test_recipe = Recipe.create({:name => "Country Skillet", :instruction => "has many"})
      visit "/recipes/#{test_recipe.id}"
      fill_in('update-recipe-name', :with => 'Country Hashbrown')
      fill_in('update-recipe-instruction', :with => '7 easy steps')
      click_button('Update!')
      expect(page).to have_content "Country Hashbrown"
    end
  end

  describe "the delete recipes path" do
    it "will let the user delete a recipe from the database" do
      test_recipe = Recipe.create({:name => "Country Skillet", :instruction => "has many"})
      visit "/recipes/#{test_recipe.id}"
      click_button('Delete!')
      expect(page).to have_content 'Infinite'
    end
  end

  describe "the create ingredients path" do
    it "allows the user to add new ingredients to a recipe" do
      test_recipe = Recipe.create({:name => "Baja Skillet", :instruction => "has many"})
      visit "/recipes/#{test_recipe.id}"
      fill_in('new-ingredient-amount', :with => "1lb")
      fill_in('new-ingredient-name', :with => "Chicken")
      click_button('Add!')
      expect(page).to have_content "1lb Chicken"
    end
  end

  describe "the delete ingredients path" do
    it "allows the user to delete ingredients" do
      test_recipe = Recipe.create({:name => "Baja Skillet", :instruction => "has many"})
      test_ingredient = Ingredient.create({:name => "Chicken", :amount => "2lb"})
      test_recipe.ingredients.push(test_ingredient)
      visit "/recipes/#{test_recipe.id}"
      find("#ingredient-delete-#{test_ingredient.id}").click
      expect(page).to have_content "Baja Skillet"
      expect(page).not_to have_content "2lb Chicken"
    end
  end

end
