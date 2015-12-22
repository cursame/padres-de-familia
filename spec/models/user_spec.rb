require 'rails_helper'

RSpec.describe User, type: :model do
  shared_examples 'a valid user' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should have_db_index(:institution_id) }
    it { should belong_to(:institution) }

    it 'should be valid' do
      expect(user).to be_valid
    end
  end

  shared_examples 'an invalid user' do
    it 'should be invalid' do
      expect(user).to be_invalid
    end
  end

  context 'with all mandatory fields' do
    let(:user) { build(:user) }
    it_behaves_like 'a valid user'
  end

  context 'with a nil name' do
    let(:user) { build(:user, name: nil) }
    it_behaves_like 'an invalid user'
  end

  context 'with a blank name' do
    let(:user) { build(:user, name: '') }
    it_behaves_like 'an invalid user'
  end

  context 'with a nil email' do
    let(:user) { build(:user, email: nil) }
    it_behaves_like 'an invalid user'
  end

  context 'with a nil email' do
    let(:user) { build(:user, email: '') }
    it_behaves_like 'an invalid user'
  end

  context 'with a nil institution' do
    let(:user) { build(:user, institution: nil) }
    it_behaves_like 'an invalid user'
  end

  context 'with Admin factory Role' do
    it { expect(create(:admin).has_role?(:admin)).to be true }
  end

  context 'with Teacher factory Role' do
    it { expect(create(:teacher).has_role?(:teacher)).to be true }
  end

  context 'with Legal Guardian factory Role' do
    it { expect(create(:legal_guardian).has_role?(:legal_guardian)).to be true }
  end

  context 'with Student factory Role' do
    it { expect(create(:student).has_role?(:student)).to be true }
  end
end
