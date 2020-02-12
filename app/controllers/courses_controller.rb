class CoursesController < ApplicationController
  before_action :require_logged_in
  before_action :set_student
  before_action :check_owner

  def new
    if student_exists_and_correct
      @course = Course.new
    else
      redirect_to student_path(current_student)
    end
  end

  def create
    if student_exists_and_correct
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
    if student_exists_and_correct
      @courses = Course.where(student_id: current_student.id)
    else
      redirect_to student_path(current_student)
    end
  end

  def show
    verify_course
  end

  def edit
    verify_course
  end

  def update
    set_course
    @course.update(params.require(:course).permit(:course_name))
    redirect_to student_course_path(@student, @course)
  end

  def destroy
    set_course.destroy
    redirect_to student_path(@student)
  end

  private

    def course_params
      params.require(:course).permit(:course_name)
    end

    def set_student
      @student = Student.find_by(id: params[:student_id])
    end

    def find_course
      Course.find_by(id: params[:id])
    end

    def set_course
      @course = Course.find_by(id: params[:id])
    end

    def verify_course
      if find_course
        set_course
        if current_student.id == @course.student_id
          set_course
        else
          redirect_to student_path(current_student)
        end
      else
        redirect_to student_path(current_student)
      end
    end
end
