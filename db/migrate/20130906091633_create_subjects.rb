class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.boolean :elective

      t.timestamps
    end
  end
end
