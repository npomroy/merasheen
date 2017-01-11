class AddOwnerIdToTripApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :trip_applications, :owner_id, :integer
  end
end
