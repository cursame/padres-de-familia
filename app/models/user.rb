class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :trackable, :validatable
  rolify

  include DeviseTokenAuth::Concerns::User

  scope :has_role, lambda { |role| includes(:roles).where(:roles => { :name=>  role }) }
  scope :institution, -> (institution_id) { where(institution_id: institution_id) }

  validates_presence_of :name

  belongs_to :institution
  validates :institution, presence: true

  def add_role_admin
    self.add_role :admin
  end

  def add_role_teacher
    self.add_role :teacher
  end

  def add_role_legal_guardian
    self.add_role :legal_guardian
  end

  def add_role_student
    self.add_role :student
  end
end
