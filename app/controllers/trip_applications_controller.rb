class TripApplicationsController < ApplicationController
   def new
       @application = TripApplication.new
   end
   
   def create
      @application = TripApplication.new( application_params )
      @application.trip_id = params[:trip_id]
      @application.user_id = current_user.id
      if @application.save
          flash[:success] = "Application submitted"
          redirect_to trips_path
      else
          flash[:error] = "Application failed"
          render action: :new
      end
   end
   
   def show
      @application = TripApplication.find(params[:id]) 
      @owner = User.find(Trip.find(@application.trip_id).user_id).profile
   end
   
   def destroy
      TripApplication.find(params[:id]).destroy
      redirect_to trip_trip_applications_path
   end
   
   def index
      @applications = TripApplication.where("trip_id = ?", params[:trip_id])
   end
   
   private
        def application_params
           params.require(:trip_application).permit(:seat_total, :max_price_per_seat, :details, :user_id, :trip_id) 
        end
end