require('spec_helper')
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("recipe box app", {:type => :feature}) do

  describe("the view recipes path") do
      it 'will let the user see a list of recipes' do
        Recipe.create({:name => "Beef Wellington", :instruction => "has many"})
        visit '/'
        expect(page).to have_content "Beef Wellington"
      end
  end


end
