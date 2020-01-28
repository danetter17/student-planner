class Course < ActiveRecord::Base
  has_many :assignments, dependent: :destroy
  has_many :students, through: :assignments

  validates :course_name, presence: true
end
