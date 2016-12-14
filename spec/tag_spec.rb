require('spec_helper')

describe Tag do
  describe '#recipes' do
    it 'will establish the many to many relationship' do
      steak_pie = Recipe.create({:name => "Steak Pie", :instruction => "Many"})
      test_tag = Tag.create({:name => "meat"})
      steak_pie.tags.push(test_tag)
      expect(test_tag.recipes).to eq [steak_pie]
    end
  end
  describe '.find_by_name' do
    it 'will find the tag by name' do
      test_tag = Tag.create({:name => "meaty"})
      expect(Tag.find_by_name("meaty")).to eq test_tag

    end
  end

end
