require 'rails_helper'

RSpec.describe Member, type: :model do
  context 'validation' do
    context 'success' do
      it 'should have valid attributes' do
        member = build(:member)
        member.should be_valid
      end
    end

    context 'failure' do
      it 'should not have empty name' do
        member = build(:member, name: '')
        member.should_not be_valid
      end

      it 'should not have name length less than 2' do
        member = build(:member, name: 'a')
        member.should_not be_valid
      end

      it 'should not have empty address' do
        member = build(:member, address: '')
        member.should_not be_valid
      end

      it 'should not have address length less than 5' do
        member = build(:member, address: 'aaaa')
        member.should_not be_valid
      end

      it 'should not have empty phone' do
        member = build(:member, phone: '')
        member.should_not be_valid
      end

      it 'should not have phone less than 5' do
        member = build(:member, phone: '1234')
        member.should_not be_valid
      end

      it 'should not have phone more than 15' do
        member = build(:member, phone: '1234567890123456')
        member.should_not be_valid
      end

      it 'should not have empty is male flag' do
        member = build(:member, is_male: '')
        member.should_not be_valid
      end

      it 'should not have empty code' do
        member = build(:member, code: '')
        member.should_not be_valid
      end

      it 'should not have empty validity date' do
        member = build(:member, validity_date: '')
        member.should_not be_valid
      end

      it 'should not have invalide validity date' do
        member = build(:member, validity_date: 'har kuch')
        member.should_not be_valid
      end

      it 'should not have empty is author flag' do
        member = build(:member, is_author: '')
        member.should_not be_valid
      end

      it 'should not have empty library id' do
        member = build(:member, library_id: '')
        member.should_not be_valid
      end

      it 'should not have invalid library id' do
        member = build(:member, library_id: 'a')
        member.should_not be_valid
      end
    end
  end

  context 'association' do
    context 'success' do
      it 'should have many issue histories' do
        member = create(:member)
        history1 = create(:issue_history, member_id: member.id)
        history2 = create(:issue_history, member_id: member.id)
        member.issue_histories.includes(history1, history2).should be_truthy
      end

      it 'should belong to library' do
        library = create(:library)
        member = create(:member)
        member.library.should eq library
      end
    end
  end
end
