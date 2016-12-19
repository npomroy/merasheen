class TripApplicationsController < ApplicationController
   def new
       @application = TripApplication.new
   end
end