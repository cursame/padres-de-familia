class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :recoverable, :trackable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User
end
