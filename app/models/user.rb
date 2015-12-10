class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :trackable, :validatable
  rolify

  include DeviseTokenAuth::Concerns::User
  validates_presence_of :name
end
