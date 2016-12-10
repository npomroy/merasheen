class CreateBoats < ActiveRecord::Migration[5.0]
  def change
    create_table :boats do |t|
      t.string :name
      t.string :owner
      t.string :home_port
      t.integer :capacity
      t.decimal :price
      t.decimal :speed
      t.text :comments
      t.timestamps
    end
  end
end
