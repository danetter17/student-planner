class Course < ActiveRecord::Base
  has_many :assignments
  has_many :students, through: :assignments

  validates :school_name, :instructor, presence: true
end
