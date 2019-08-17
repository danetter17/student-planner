class Assignment < ActiveRecord::Base
  belongs_to :course
  belongs_to :student
  accepts_nested_attributes_for :course

  validates :course_id, :student_id, :due_date, :title, presence: true

end
