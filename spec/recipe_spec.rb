require('spec_helper')

describe Recipe do
  describe '#ingredients' do
    it "creates a many to one relationship properly" do
      steak_pie = Recipe.create({:name => "Steak Pie", :instruction => "Many"})
      beef = Ingredient.create({:name => "Beef", :amount => "2lb", :recipe_id => steak_pie.id})
      expect(steak_pie.ingredients).to eq [beef]
    end
    it "returns an empty array if there are no ingredients" do
      steak_pie = Recipe.create({:name => "Steak Pie", :instruction => "Many"})
      expect(steak_pie.ingredients).to eq []
    end
  end
end
