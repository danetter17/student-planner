class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.string :title
      t.date :due_date
      t.text :assignment_details
      t.integer :student_id
      t.integer :course_id
    end
  end
end
