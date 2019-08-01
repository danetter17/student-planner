class SessionsController < ApplicationController
	def new
		@students = Student.all
	end

	def create
		@student = Student.find_by(id: params[:student][:id])
		@student = @student.try(:authenticate, params[:student][:password])
		redirect_to root_path unless @student
		session[:student_id] = @student.id
		redirect_to student_path(@student)
	end

	def destroy
		session.delete :student_id
		redirect_to root_path
	end
end
