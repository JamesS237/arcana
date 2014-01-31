class DropAverages < ActiveRecord::Migration
  def change
    drop_table :averages
  end
end
