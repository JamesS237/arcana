class AddTermToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :term, :integer
  end
end
