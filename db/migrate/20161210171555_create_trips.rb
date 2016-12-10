class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :depart_from
      t.datetime :depart_date_time
      t.integer :boat_id
      t.string :skipper
      t.integer :available_seats
      t.decimal :starting_price
      t.text :comments
      t.timestamps
    end
  end
end
