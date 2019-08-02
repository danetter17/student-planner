class StudentsController < ApplicationController
  before_action :require_logged_in, only: :show 

  def new
    @student = Student.new
  end

  def create
		@student = Student.new(student_params)
    #raise params.inspect
    #binding.pry
    if @student.save
      session[:student_id] = @student.id
  		redirect_to student_path(@student)
	  else
      redirect_to root_path
    end
	end

  def show
    if logged_in?
      @student = Student.find_by(id: params[:id])
    else
      redirect_to root_path
    end
  end

  private

  def student_params
		params.require(:student).permit(:name, :email, :password)
	end

end
