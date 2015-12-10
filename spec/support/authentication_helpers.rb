module Requests
  module AuthenticationHelpers
    def sign_in_as_a_valid_user(user, password)
      user_params = { email: user, password: password }
      post v1_user_session_path, user_params, format: :json
    end
  end
end
