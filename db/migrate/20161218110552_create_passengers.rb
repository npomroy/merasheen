class CreatePassengers < ActiveRecord::Migration[5.0]
  def change
    create_table :passengers do |t|
      t.integer :user_id
      t.string :title
      t.text :details
      t.datetime :earliestdate
      t.datetime :latestdate
      t.timestamps
    end
  end
end
