class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :trackable, :validatable
  rolify

  include DeviseTokenAuth::Concerns::User

  scope :has_role, lambda { |role| includes(:roles).where(:roles => { :name=>  role }) }
  scope :institution, -> (institution_id) { where(institution_id: institution_id) }

  validates_presence_of :name

  belongs_to :institution
  validates :institution, presence: true
end
