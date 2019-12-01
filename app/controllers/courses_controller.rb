class CoursesController < ApplicationController
  before_action :require_logged_in
  
  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)

    if @course.save
      redirect_to student_courses_path(@student)
    else
      render :new
    end
  end

  def index
    student = Student.find_by(id: params[:student_id])
    @courses = Course.all
    #binding.pry
  end

  def show
    student = Student.find_by(id: params[:student_id])
    @course = student.courses.find_by(id: params[:id])
  end

  def edit
  end

  def update
  end

  private

    def course_params
      params.require(:course).permit(:course_name)
    end
end
