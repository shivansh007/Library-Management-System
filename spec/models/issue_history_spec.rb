require 'rails_helper'

RSpec.describe IssueHistory, type: :model do
  before(:all) do
    @library = create(:library)
    @category = create(:category)
    @book = create(:book, library_id: @library.id, category_id: @category.id)
    @member = create(:member, library_id: @library.id)
  end

  context 'validation' do
    context 'success' do
      it 'should have valid attributes' do
        issue_history = build(:issue_history, book_id: @book.id, member_id: @member.id)
        issue_history.should be_valid
      end
    end

    context 'failure' do
      it 'should not have empty issue type' do
        issue_history = build(:issue_history, book_id: @book.id, member_id: @member.id, issue_type: '')
        issue_history.should_not be_valid
      end

      it 'should not have empty issue date' do
        issue_history = build(:issue_history, book_id: @book.id, member_id: @member.id, issue_date: '')
        issue_history.should_not be_valid
      end

      it 'should not have invalid issue date' do
        issue_history = build(:issue_history, book_id: @book.id, member_id: @member.id, issue_date: 'aur bhi har kuch')
        issue_history.should_not be_valid
      end

      it 'should not have invalid return date' do
        issue_history = build(:issue_history, book_id: @book.id, member_id: @member.id, return_date: 'ye bhi har kuch')
        issue_history.should_not be_valid
      end

      it 'should not have empty member id' do
        issue_history = build(:issue_history, book_id: @book.id, member_id: '')
        issue_history.should_not be_valid
      end

      it 'should not have empty book id' do
        issue_history = build(:issue_history, member_id: @member.id, book_id: '')
        issue_history.should_not be_valid
      end

      it 'should not have invalid member id' do
        issue_history = build(:issue_history, book_id: @book.id, member_id: 'a')
        issue_history.should_not be_valid
      end

      it 'should not have invalid book id' do
        issue_history = build(:issue_history, member_id: @member.id, book_id: 'a')
        issue_history.should_not be_valid
      end
    end
  end

  context 'association' do
    context 'success' do
      it 'should belong to member' do
        issue_history = create(:issue_history, book_id: @book.id, member_id: @member.id)
        issue_history.member.should eq @member
      end

      it 'should belong to book' do
        issue_history = create(:issue_history, book_id: @book.id, member_id: @member.id)
        issue_history.book.should eq @book
      end
    end
  end
end
