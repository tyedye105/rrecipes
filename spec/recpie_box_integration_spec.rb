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

end
