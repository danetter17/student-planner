class Course < ActiveRecord::Base
  has_many :assignments
  has_many :students, through: :assignments

  validates :course_name, :instructor, presence: true
end
