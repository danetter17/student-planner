class StudentsController < ApplicationController
  before_action :require_logged_in, only: :show 

  def new
    @student = Student.new
  end

  def create
		@student = Student.new(student_params)
    if @student.save
      session[:student_id] = @student.id
  		redirect_to student_path(@student)
	  else
      render :new
    end
	end

  def index
    redirect_to student_path(current_student)
  end

  def show
    set_student_if_correct
    if student_exists_and_correct
      @assignments = Assignment.where(student_id: current_student.id)
      @courses = Course.where(student_id: current_student.id)
      @assignments_due_soon = @student.assignments.due_soon
    else
      redirect_to student_path(current_student)
    end
  end

  def edit
    set_student_if_correct
  end

  def update
    @student = current_student
    @student.update(params.require(:student).permit(:email, :password))
    redirect_to student_path(@student)
  end

  def destroy
    set_student.destroy
    redirect_to root_path
  end

  private

    def student_params
		  params.require(:student).permit(:name, :email, :password)
	  end

    def set_student
      @student = Student.find_by(id: params[:id])
    end

    def correct_student
      if logged_in? and @student
        unless current_student.id == @student.id
          redirect_to student_path(current_student)
        end
      else
        redirect_to student_path(current_student)
      end
    end

    def set_student_if_correct
      @student = Student.find_by(id: params[:id])
      correct_student
    end
end
