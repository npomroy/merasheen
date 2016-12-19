class TripApplicationsController < ApplicationController
   def new
       @application = TripApplication.new
   end
   
   def create
      @application = TripApplication.new( application_params )
      if @application.save
          flash[:success] = "Application submitted"
          redirect_to trips_path
      else
          flash[:error] = "Application failed"
          render action: :new
      end
   end
   
   private
        def application_params
           params.require(:trip_application).permit(:seat_total, :max_price_per_seat, :trip_id) 
        end
end