class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_student

  def current_student
  	Student.find_by(id: session[:student_id]) || Student.new
  end

  def logged_in?
  	current_student.id != nil
  end

  def require_logged_in
    return redirect_to(controller: 'sessions', action: 'new') unless logged_in?
  end

  def check_owner
    if @student.blank? || @student.id != current_student.id
      redirect_to student_path(current_student), error: 'Sorry, you can\'t view another Users resources.'
    end
  end
end
