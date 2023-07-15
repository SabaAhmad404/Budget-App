require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:author) { User.create(name: 'John Doe') }
  let(:category) { Category.new(name: 'Test Category', author: author) }

  

  describe 'validations' do
    it 'validates presence of name' do
      category.name = nil
      expect(category).to_not be_valid
      expect(category.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of icone' do
      category.icone = nil
      expect(category).to_not be_valid
      expect(category.errors[:icone]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      expect(category.author).to eq(author)
    end

    it 'has and belongs to many entities' do
      expect(category.entities).to be_empty

      entity = Entity.create(amount: 100)
      category.entities << entity

      expect(category.entities).to include(entity)
    end
  end
end
