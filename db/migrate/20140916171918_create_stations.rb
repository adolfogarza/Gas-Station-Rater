class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :legal_name
      t.integer :counter_honesty
      t.integer :counter_speed_service
      t.integer :counter_customer_service
      t.integer :counter_comments
      t.timestamps
    end
  end
end
