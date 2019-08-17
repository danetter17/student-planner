class AssignmentsController < ApplicationController
  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.create(assignment_params)
    #binding.pry
    #raise params.inspect
    if @assignment
      redirect_to student_assignments_path(@student)
    else
      render :new
    end
  end

  def index
    @assignments = Assignment.where(student_id: params[:student_id])
    #binding.pry
  end

  def show
    student = Student.find_by(id: params[:student_id])
    @assignment = student.assignments.find_by(id: params[:id])
  end

  def edit
  end

  def update
  end

  private

    def assignment_params
      params.require(:assignment).permit(:title, :due_date, :course_id, :student_id, courses_attributes: [:course_name])
    end
end
