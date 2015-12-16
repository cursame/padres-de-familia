class Institution < ActiveRecord::Base
  validates_presence_of :name

  has_many :users
end

