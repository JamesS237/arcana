class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :subject_id
      t.string :type_id
      t.string :title
      t.boolean :exam

      t.timestamps
    end
  end
end
