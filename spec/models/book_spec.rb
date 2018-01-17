require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'validation' do
    context 'success' do
      it 'should have valid attributes' do
        book = build(:book)
        book.should be_valid
      end
    end

    context 'failure' do
      it 'should not have empty name' do
        book = build(:book, name: '')
        book.should_not be_valid
      end

      it 'should not have empty author' do
        book = build(:book, name: '')
        book.should_not be_valid
      end

      it 'should not have author with less than 2 characters' do
        book = build(:book, author: 'a')
        book.should_not be_valid
      end

      it 'should not have empty ISBN code' do
        book = build(:book, isbn: '')
        book.should_not be_valid
      end

      it 'should not have empty price' do
        book = build(:book, price: '')
        book.should_not be_valid
      end

      it 'should not have invalid price' do
        book = build(:book, price: 'a')
        book.should_not be_valid
      end

      it 'should not have empty publication' do
        book = build(:book, publication: '')
        book.should_not be_valid
      end

      it 'should not have empty version' do
        book = build(:book, version: '')
        book.should_not be_valid
      end

      it 'should not have empty no. of copies' do
        book = build(:book, no_of_copies: '')
        book.should_not be_valid
      end

      it 'should not have invalid no. of copies' do
        book = build(:book, no_of_copies: 'a')
        book.should_not be_valid
      end

      it 'should not have empty library id' do
        book = build(:book, library_id: '')
        book.should_not be_valid
      end

      it 'should not have invalid library id' do
        book = build(:book, library_id: 'a')
        book.should_not be_valid
      end

      it 'should not have empty category id' do
        book = build(:book, category_id: '')
        book.should_not be_valid
      end

      it 'should not have invalid category id' do
        book = build(:book, category_id: 'a')
        book.should_not be_valid
      end
    end
  end

  context 'association' do
    context 'success' do
      it 'should belong to library' do
        library = create(:library)
        book = create(:book, library_id: library.id)
        book.library.should eq library
      end

      it 'should belong to category' do
        category = create(:category)
        book = create(:book, category_id: category.id)
        book.category.should eq category
      end

      it 'should have many issue histories' do
        book = create(:book)
        history1 = create(:issue_history, book_id: book.id)
        history2 = create(:issue_history, book_id: book.id)
        book.issue_histories.includes(history1, history2).should be_truthy
      end
    end
  end
end
