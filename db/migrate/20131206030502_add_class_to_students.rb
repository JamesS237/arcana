class AddClassToStudents < ActiveRecord::Migration
  def change
    add_column :students, :class_group, :integer
  end
end
