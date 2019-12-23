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
      redirect_to root_path
    end
	end

  def show
    @student = Student.find_by(id: params[:id])
    if logged_in? and @student
      unless current_student.id == @student.id
        redirect_to student_path(current_student), error: 'Sorry, you can\'t view another Users profile.'
      end
    else
      redirect_to root_path
    end
  end

  private

    def student_params
		  params.require(:student).permit(:name, :email, :password)
	  end
end
