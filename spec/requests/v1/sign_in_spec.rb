require 'rails_helper'

RSpec.describe 'Sign in API', type: :request do

  context "when user is invalid" do
    before(:each) do
      post v1_user_session_path, { email: 'juan@prueba.com', password: '1q2w3e4r5t6y' }, format: :json
    end

    it 'renders an errors json' do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response).to have_key(:errors)
    end

    it { expect(response.status).to eq 401 }
  end

  context 'when user is valid' do
    before(:each) do
      user = create(:user)
      sign_in_as_a_valid_user(user.email, user.password)
    end

    it 'renders a user data json' do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response).to have_key(:data)
    end

    it { expect(response.status).to eq 200 }
  end
end
