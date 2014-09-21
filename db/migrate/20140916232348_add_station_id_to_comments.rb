class AddStationIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :station_id, :integer
    add_index :comments, :station_id
  end
end
