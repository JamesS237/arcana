class AddTermToResults < ActiveRecord::Migration
  def change
    add_column :results, :term, :integer
  end
end
