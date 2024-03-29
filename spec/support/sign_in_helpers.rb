module Request
  module SignInHelpers
    def sign_in_as_a_valid_user(email, password)
      user_params = { email: email, password: password }
      post v1_user_session_path, user_params, format: :json
    end
  end
end
