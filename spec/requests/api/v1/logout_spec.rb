require 'rails_helper'

RSpec.describe 'Log out API', type: :request do


  context 'when user is authenticated' do
    before(:each) do
      user = create(:user)
      sign_in_as_a_valid_user(user.email, user.password)
    end

    it 'user logout correct' do
      header = {
        "access-token": response.header["access-token"],
        client: response.header["client"],
        uid: response.header["uid"]
      }
      delete destroy_v1_user_session_path, header, format: :json
      expect(response.body["success"]).not_to be_blank

    end
  end

  context 'when send invalid access-token' do
    before(:each) do
      user = create(:user)
      sign_in_as_a_valid_user(user.email, user.password)
    end

    it 'respond error message' do
      header = {
        "access-token": "f4k37ok3n",
        client: response.header["client"],
        uid: response.header["uid"]
      }
      delete destroy_v1_user_session_path, header, format: :json
      expect(response.body["errors"]).not_to be_blank
    end
  end

end
