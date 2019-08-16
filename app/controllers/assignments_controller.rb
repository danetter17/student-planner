class AssignmentsController < ApplicationController
  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new(assignment_params)

    if @assignment.save
      redirect_to student_assignment_path(@student)
    else
      render :new
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  private

    def assignment_params
      params.require(:assignment).permit(:title, :due_date, :course_id, :student_id)
    end
end
