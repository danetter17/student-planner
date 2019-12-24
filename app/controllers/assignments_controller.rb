class AssignmentsController < ApplicationController
  before_action :require_logged_in
  before_action :set_student

  def new
    @assignment = Assignment.new
    @courses = Course.where(student_id: current_student.id)
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.student_id = current_student.id if current_student

    if @assignment.save
      redirect_to student_assignments_path(@student)
    else
      render :new
    end
  end

  def index
    #@student = Student.find_by(id: params[:student_id])
    #@assignments = Assignment.where(student_id: params[:student_id])
    #binding.pry
    if @student && @student.id == current_student.id
      @assignments = Assignment.where(student_id: current_student.id)
    else
      redirect_to student_path(current_student), error: 'Sorry, you can\'t view another Users assignments.'
    end
  end

  def show
    student = Student.find_by(id: params[:student_id])
    @assignment = student.assignments.find_by(id: params[:id])
    #binding.pry
  end

  def edit
    @assignment = Assignment.find_by(id: params[:id])
  end

  def update
    student = Student.find_by(id: params[:student_id])
    @assignment = Assignment.find_by(id: params[:id])
    @assignment.update(params.require(:assignment).permit(:title, :due_date))
    redirect_to student_assignment_path(student, @assignment)
  end

  def destroy
    @student = Student.find_by(id: params[:student_id])
    @assignment = Assignment.find_by(id: params[:id]).destroy
    redirect_to student_path(@student), notice: 'Assignment was successfully completed.'
  end

  private

    def assignment_params
      params.require(:assignment).permit(:title, :due_date, :course_id, :student_id, course_attributes: [:course_name])
    end

    def set_student
      @student = Student.find_by(id: params[:student_id])
    end
end
