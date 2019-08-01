class Assignment < ActiveRecord::Base
  belongs_to :course
  belongs_to :student

  validates :course_id, :student_id, :due_date, :title, presence: true

end
