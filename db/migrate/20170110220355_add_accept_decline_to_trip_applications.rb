class AddAcceptDeclineToTripApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :trip_applications, :accepted, :boolean, default: false
    add_column :trip_applications, :declined, :boolean, default: false
  end
end
