require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validation' do
    context 'success' do
      it 'should have valid attributes' do
        category = build(:category)
        category.should be_valid
      end
    end

    context 'failure' do
      it 'should not have empty name' do
        category = build(:category, name: '')
        category.should_not be_valid
      end
    end
  end
  context 'association' do
    context 'success' do
      it 'should have many books' do
        category = create(:category)
        book1 = create(:book, category_id: category.id)
        book2 = create(:book, category_id: category.id)
        category.books.includes(book1, book2).should be_truthy
      end
    end
  end
end
