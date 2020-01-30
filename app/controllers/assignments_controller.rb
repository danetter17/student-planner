class AssignmentsController < ApplicationController
  before_action :require_logged_in
  before_action :set_student
  before_action :check_owner

  def new
    if @student && @student.id == current_student.id
      @assignment = Assignment.new
      @courses = Course.where(student_id: current_student.id)
    else
      redirect_to student_path(current_student)
    end
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.student_id = current_student.id if current_student
    @courses = Course.where(student_id: current_student.id)

    if @assignment.save
      redirect_to student_assignments_path(@student)
    else
      render :new
    end
  end

  def index
    if @student && @student.id == current_student.id
      @assignments = Assignment.where(student_id: current_student.id)
    else
      redirect_to student_path(current_student)
    end
  end

  def show
    @assignment = Assignment.find(params[:id])
    if current_student.id == @assignment.student_id
      @assignment = Assignment.find(params[:id])
    else
      redirect_to student_path(current_student)
    end
  end

  def edit
    @assignment = Assignment.find(params[:id])
    if current_student.id == @assignment.student_id
      @assignment = Assignment.find(params[:id])
    else
      redirect_to student_path(current_student)
    end
  end

  def update
    student = Student.find_by(id: params[:student_id])
    @assignment = @student.assignments.find_by(id: params[:id])
    @assignment.update(params.require(:assignment).permit(:title, :due_date, :assignment_details))
    redirect_to student_assignment_path(student, @assignment)
  end

  def destroy
    @student = Student.find_by(id: params[:student_id])
    @assignment = @student.assignments.find_by(id: params[:id]).destroy
    redirect_to student_path(@student)
  end

  private

    def assignment_params
      params.require(:assignment).permit(:title, :due_date, :assignment_details, :course_id, :student_id)
    end

    def set_student
      @student = Student.find_by(id: params[:student_id])
    end
end
