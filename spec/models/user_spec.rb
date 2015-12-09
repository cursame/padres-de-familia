require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'User fields' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
  end

  scenario 'Valid with Factory values' do
    user = build(:user)
    expect(user.valid?).to be(true)
  end

  scenario 'Invalid with NIL name field' do
    user = build(:user, name: nil)
    expect(user.invalid?).to be(true)
  end

  scenario 'Invalid with blank name field' do
    user = build(:user, name: '')
    expect(user.invalid?).to be(true)
  end

  scenario 'Invalid with NIL email field' do
    user = build(:user, email: nil)
    expect(user.invalid?).to be(true)
  end

  scenario 'Invalid with blank email field' do
    user = build(:user, email: '')
    expect(user.invalid?).to be(true)
  end
end
