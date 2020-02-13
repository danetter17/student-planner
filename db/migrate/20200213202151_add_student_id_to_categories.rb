class AddStudentIdToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :student_id, :integer
  end
end
