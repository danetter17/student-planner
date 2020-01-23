class SessionsController < ApplicationController
	def new
		@student = Student.new
	end

	def create
		@student = Student.find_by(email: params[:student][:email])
    if @student && @student.authenticate(params[:student][:password])
      session[:student_id] = @student.id
      redirect_to student_path(@student)
    else
      redirect_to login_path
    end
	end

	def destroy
		session.delete :student_id
		redirect_to root_path
	end

	def omniauth
		#binding.pry
		@student = Student.find_or_create_by(uid: auth['uid']) do |u|
			u.name = auth['info']['name']
			u.email = auth['info']['email']
			u.password = "password"
		end
		#binding.pry
    #@student = Student.from_omniauth(auth)
    #@student.save
    session[:student_id] = @student.id
		redirect_to student_path(@student)
  end

  private

  	def auth
    	request.env['omniauth.auth']
  	end
end
