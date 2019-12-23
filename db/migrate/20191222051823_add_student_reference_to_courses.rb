class AddStudentReferenceToCourses < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :student, references: :students
  end
end
