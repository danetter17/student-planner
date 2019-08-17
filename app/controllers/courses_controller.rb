class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)

    if @course
      redirect_to student_courses_path(@student)
    else
      render :new
    end
  end

  def index
    @courses = Course.where(student_id: params[:student_id])
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
      params.require(:course).permit(:course_name, :instructor)
    end
end
