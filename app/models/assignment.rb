class Assignment < ActiveRecord::Base
  belongs_to :course
  belongs_to :student
  belongs_to :category
  # accepts_nested_attributes_for :course

  validates :course_id, :student_id, :due_date, :title, presence: true
  scope :due_soon, -> { where(due_date: Date.current..7.days.from_now) }

  # def course_attributes=(attributes)
  #   binding.pry
  #   if attributes[:course_name].blank?
  #     self.course = Course.find_by(id: params[:course_id])
  #   else
  #     self.course = Course.find_or_create_by(attributes)
  #     self.course
  #   end
  # end
end
