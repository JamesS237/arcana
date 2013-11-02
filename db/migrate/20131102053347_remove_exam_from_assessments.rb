class RemoveExamFromAssessments < ActiveRecord::Migration
  def change
    remove_column :assessments, :exam, :boolean
  end
end
