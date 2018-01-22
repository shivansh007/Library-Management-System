require 'rails_helper'

RSpec.describe Book, type: :model do
  before(:all) do
    @library = create(:library)
    @category = create(:category)
  end

  context 'validation' do
    context 'success' do
      it 'should have valid attributes' do
        book = build(:book, library_id: @library.id, category_id: @category.id)
        book.should be_valid
      end
    end

    context 'failure' do
      it 'should not have empty name' do
        book = build(:book, library_id: @library.id, category_id: @category.id, name: '')
        book.should_not be_valid
      end

      it 'should not have empty author' do
        book = build(:book, library_id: @library.id, category_id: @category.id, name: '')
        book.should_not be_valid
      end

      it 'should not have author with less than 2 characters' do
        book = build(:book, library_id: @library.id, category_id: @category.id, author: 'a')
        book.should_not be_valid
      end

      it 'should not have empty ISBN code' do
        book = build(:book, library_id: @library.id, category_id: @category.id, isbn: '')
        book.should_not be_valid
      end

      it 'should not have empty price' do
        book = build(:book, library_id: @library.id, category_id: @category.id, price: '')
        book.should_not be_valid
      end

      it 'should not have invalid price' do
        book = build(:book, library_id: @library.id, category_id: @category.id, price: 'a')
        book.should_not be_valid
      end

      it 'should not have empty publication' do
        book = build(:book, library_id: @library.id, category_id: @category.id, publication: '')
        book.should_not be_valid
      end

      it 'should not have empty version' do
        book = build(:book, library_id: @library.id, category_id: @category.id, version: '')
        book.should_not be_valid
      end

      it 'should not have empty no. of copies' do
        book = build(:book, library_id: @library.id, category_id: @category.id, no_of_copies: '')
        book.should_not be_valid
      end

      it 'should not have invalid no. of copies' do
        book = build(:book, library_id: @library.id, category_id: @category.id, no_of_copies: 'a')
        book.should_not be_valid
      end

      it 'should not have empty library id' do
        book = build(:book, category_id: @category.id, library_id: '')
        book.should_not be_valid
      end

      it 'should not have invalid library id' do
        book = build(:book, category_id: @category.id, library_id: 'a')
        book.should_not be_valid
      end

      it 'should not have empty category id' do
        book = build(:book, library_id: @library.id, category_id: '')
        book.should_not be_valid
      end

      it 'should not have invalid category id' do
        book = build(:book, library_id: @library.id, category_id: 'a')
        book.should_not be_valid
      end
    end
  end

  context 'association' do
    context 'success' do
      it 'should belong to library' do
        book = create(:book, library_id: @library.id, category_id: @category.id)
        book.library.should eq @library
      end

      it 'should belong to category' do
        book = create(:book, library_id: @library.id, category_id: @category.id)
        book.category.should eq @category
      end

      it 'should have many issue histories' do
        book = create(:book, library_id: @library.id, category_id: @category.id)
        member = create(:member, library_id: @library.id)
        history1 = create(:issue_history, book_id: book.id, member_id: member.id)
        history2 = create(:issue_history, book_id: book.id, member_id: member.id)
        book.issue_histories.includes(history1, history2).should be_truthy
      end
    end
  end
end
