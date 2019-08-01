class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :school_name
      t.string :instructor
    end
  end
end
