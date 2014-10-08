class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :honesty
      t.integer :speed_service
      t.integer :customer_service

      t.timestamps
    end
  end
end
