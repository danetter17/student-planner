class CoursesController < ApplicationController
  before_action :require_logged_in
  before_action :set_student
  before_action :check_owner

  def new
    if @student && @student.id == current_student.id
      @course = Course.new
    else
      redirect_to student_path(current_student)
    end
  end

  def create
    if @student && @student.id == current_student.id
      @course = Course.create(course_params)
      @course.student_id = params[:student_id]

      if @course.save
        redirect_to student_courses_path(@student)
      else
        render :new
      end
    else
      redirect_to student_path(current_student)
    end
  end

  def index
    if @student && @student.id == current_student.id
      @courses = Course.where(student_id: current_student.id)
    else
      redirect_to student_path(current_student)
    end
  end

  def show
    @course = Course.find(params[:id])
    if current_student.id == @course.student_id
      @course = Course.find(params[:id])
    else
      redirect_to student_path(current_student)
    end
  end

  def edit
    @course = Course.find(params[:id])
    if current_student.id == @course.student_id
      @course = Course.find_by(id: params[:id])
    else
      redirect_to student_path(current_student)
    end
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
    redirect_to student_path(@student)
  end

  private

    def course_params
      params.require(:course).permit(:course_name)
    end

    def set_student
      @student = Student.find_by(id: params[:student_id])
    end
end
