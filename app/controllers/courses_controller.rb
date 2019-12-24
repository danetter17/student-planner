class CoursesController < ApplicationController
  before_action :require_logged_in
  before_action :set_student

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
    @course.student_id = params[:student_id]

    if @course.save
      redirect_to student_courses_path(@student)
    else
      render :new
    end
  end

  def index
    if @student && @student.id == current_student.id
      @courses = Course.where(student_id: current_student.id)
    else
      redirect_to student_path(current_student), error: 'Sorry, you can\'t view another Users courses.'
    end
    #binding.pry
  end

  def show
    student = Student.find_by(id: params[:student_id])
    @course = student.courses.find_by(id: params[:id])
  end

  def edit
    @course = Course.find_by(id: params[:id])
  end

  def update
    student = Student.find_by(id: params[:student_id])
    @course = Course.find_by(id: params[:id])
    @course.update(params.require(:course).permit(:course_name))
    redirect_to student_course_path(student, @course)
  end

  def destroy
    @student = Student.find_by(id: params[:student_id])
    @course = Course.find_by(id: params[:id]).destroy
    redirect_to student_path(@student), notice: 'Course was successfully deleted.'
  end

  private

    def course_params
      params.require(:course).permit(:course_name)
    end

    def set_student
      @student = Student.find_by(id: params[:student_id])
    end
end
