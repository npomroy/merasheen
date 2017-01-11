class AllAboardController < ApplicationController
   def applications
       @myapplications = TripApplication.where("user_id = ?", current_user.id)
       @tripapplications = TripApplication.where("owner_id = ?", current_user.id)
   end
end