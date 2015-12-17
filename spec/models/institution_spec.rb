require 'rails_helper'

RSpec.describe Institution, type: :model do
  shared_examples 'a valid institution' do
    it { should validate_presence_of(:name) }

    it 'should be valid' do
      expect(institution).to be_valid
    end
  end

  shared_examples 'an invalid institution' do
    it 'should be invalid' do
      expect(institution).to be_invalid
    end
  end

  context 'with all mandatory fields' do
    let(:institution) { build(:institution) }
    it_behaves_like 'a valid institution'
  end

  context 'with a nil name' do
    let(:institution) { build(:institution, name: nil) }
    it_behaves_like 'an invalid institution'
  end

  context 'with a blank name' do
    let(:institution) { build(:institution, name: '') }
    it_behaves_like 'an invalid institution'
  end
end
