class AddCategoryIdToAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :category_id, :integer
  end
end
