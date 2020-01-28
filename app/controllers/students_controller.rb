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

  def show
    #binding.pry
    @student = Student.find_by(id: params[:id])
    if logged_in? and @student
      unless current_student.id == @student.id
        redirect_to student_path(current_student), error: 'Sorry, you can\'t view another Users profile.'
      end
    else
      redirect_to root_path
    end
  end

  def edit
    @student = Student.find_by(id: params[:id])
    if logged_in? and @student
      unless current_student.id == @student.id
        redirect_to student_path(current_student), error: 'Sorry, you can\'t view another Users profile.'
      end
    else
      redirect_to root_path
    end
  end

  def update
    @student = current_student
    @student.update(params.require(:student).permit(:email, :password))
    redirect_to student_path(@student)
  end

  private

    def student_params
		  params.require(:student).permit(:name, :email, :password)
	  end
end
