class CategoriesController < ApplicationController
  before_action :require_logged_in
  before_action :set_student
  before_action :check_owner

  def new
    if student_exists_and_correct
      @category = Category.new
    else
      redirect_to student_path(current_student)
    end
  end

  def create
    @category = Category.create(category_params)
    @category.student_id = params[:student_id]
    if @category.save
      redirect_to student_category_path(@student, @category)
    else
      render :new
    end
  end

  def show
    verify_category
  end

  def index
    if student_exists_and_correct
      @categories = Category.where(student_id: current_student.id)
    else
      redirect_to student_path(current_student)
    end
  end

  def edit
    verify_category
  end

  def update
    set_category
    @category.update(params.require(:category).permit(:title))
    redirect_to student_category_path(@student, @category)
  end

  def destroy
    set_category.destroy
    redirect_to student_path(@student)
  end

  private

    def category_params
      params.require(:category).permit(:title)
    end

    def set_student
      @student = Student.find_by(id: params[:student_id])
    end

    def find_category
      Category.find_by(id: params[:id])
    end

    def set_category
      @category = Category.find_by(id: params[:id])
    end

    def verify_category
      if find_category
        set_category
        if current_student.id == @category.student_id
          set_category
        else
          redirect_to student_path(current_student)
        end
      else
        redirect_to student_path(current_student)
      end
    end
end
