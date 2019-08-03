class SessionsController < ApplicationController
	def new
		@student = Student.new
	end

	def create
		#raise params.inspect
		#binding.pry
		@student = Student.find_by(email: params[:student][:email])
    if @student && @student.authenticate(params[:student][:password])
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

  # private
	#
  # def student_params
	# 	params.require(:student).permit(:name, :email, :password)
	# end
end
