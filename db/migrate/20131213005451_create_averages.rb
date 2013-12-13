class CreateAverages < ActiveRecord::Migration
  def change
    create_table :averages do |t|
      t.integer :student_id
      t.integer :subject_id
      t.float :t1
      t.float :t2
      t.float :t3
      t.float :t4
      t.float :exams_s1
      t.float :exams_s2
      t.boolean :overall

      t.timestamps
    end
  end
end
