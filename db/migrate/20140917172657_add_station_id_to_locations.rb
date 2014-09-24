class AddStationIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :station_id, :integer
    add_index :locations, :station_id
  end
end