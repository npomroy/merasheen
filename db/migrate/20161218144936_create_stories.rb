class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.string :title
      t.string :location
      t.date :date
      t.text :description
      t.timestamps
    end
  end
end
