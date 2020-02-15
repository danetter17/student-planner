class AssignmentsController < ApplicationController
  before_action :require_logged_in
  before_action :set_student
  before_action :check_owner

  def new
    if student_exists_and_correct
      @assignment = Assignment.new
      pickable_courses
      pickable_categories
    else
      redirect_to student_path(current_student)
    end
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.student_id = current_student.id if current_student
    pickable_courses
    pickable_categories

    if @assignment.save
      redirect_to student_assignments_path(@student)
    else
      render :new
    end
  end

  def index
    if student_exists_and_correct
      @assignments = Assignment.where(student_id: current_student.id)
      @assignments_due_soon = @student.assignments.due_soon
    else
      redirect_to student_path(current_student)
    end
  end

  def show
    verify_assignment
  end

  def edit
    verify_assignment
  end

  def update
    set_student
    set_assignment
    @assignment.update(params.require(:assignment).permit(:title, :due_date, :assignment_details))
    redirect_to student_assignment_path(@student, @assignment)
  end

  def destroy
    set_student
    set_assignment.destroy
    redirect_to student_path(@student)
  end

  private

    def assignment_params
      params.require(:assignment).permit(:title, :due_date, :assignment_details, :course_id, :category_id, :student_id)
    end

    def find_assignment
      Assignment.find_by(id: params[:id])
    end

    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def set_student
      @student = Student.find_by(id: params[:student_id])
    end

    def verify_assignment
      if find_assignment
        set_assignment
        if current_student.id == @assignment.student_id
          set_assignment
        else
          redirect_to student_path(current_student)
        end
      else
        redirect_to student_path(current_student)
      end
    end

    def pickable_courses
      @courses = Course.where(student_id: current_student.id)
    end

    def pickable_categories
      @categories = Category.where(student_id: current_student.id)
    end
end
