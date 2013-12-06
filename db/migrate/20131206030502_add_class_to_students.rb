class AddClassToStudents < ActiveRecord::Migration
  def change
    add_column :students, :class, :integer
  end
end
