class AddUserIdToTripApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :trip_applications, :user_id, :integer
  end
end
