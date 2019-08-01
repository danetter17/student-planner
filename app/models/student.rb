class Student < ActiveRecord::Base
  has_many :assignments
  has_many :courses, through: :assignments
  has_secure_password

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
