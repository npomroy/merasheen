class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :title
      t.string :link
      t.text :details
      t.datetime :startdate
      t.datetime :enddate
      t.integer :likes
      t.timestamps
    end
  end
end
