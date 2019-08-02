class SessionsController < ApplicationController
	def new
		@students = Student.all
	end

	def create
		raise params.inspect
		@student = Student.find_by(email: params[:email])
		binding.pry
    if @student && @student.authenticate(password: params[:password])
			#binding.pry
      session[:student_id] = @student.id
      redirect_to student_path(@student)
    else
      redirect_to new_student_path
    end
	end

	def destroy
		session.delete :student_id
		redirect_to root_path
	end

  private

  def student_params
		params.require(:student).permit(:name, :email, :password)
	end
end
