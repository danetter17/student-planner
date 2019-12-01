class AssignmentsController < ApplicationController
  before_action :require_logged_in
  def new
    @assignment = Assignment.new
  end

  def create
    #binding.pry
    @assignment = Assignment.new(assignment_params)
    @assignment.student_id = current_student.id if current_student
    #binding.pry
    #raise params.inspect
    if @assignment.save
      redirect_to student_assignments_path(@student)
    else
      render :new
    end
  end

  def index
    @student = Student.find_by(id: params[:student_id])
    @assignments = Assignment.where(student_id: params[:student_id])
    #binding.pry
  end

  def show
    student = Student.find_by(id: params[:student_id])
    @assignment = student.assignments.find_by(id: params[:id])
    #binding.pry
  end

  def edit
  end

  def update
  end

  private

    def assignment_params
      params.require(:assignment).permit(:title, :due_date, :course_id, :student_id, course_attributes: [:course_name])
    end
end
