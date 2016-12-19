class CreateTripApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :trip_applications do |t|
      t.integer :trip_id
      t.integer :seat_total
      t.integer :max_price_per_seat
      t.text :details
    end
  end
end
