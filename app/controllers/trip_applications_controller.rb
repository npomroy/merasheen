class TripApplicationsController < ApplicationController
   before_action :set_application, only: [:show, :destroy, :accept, :deny]
   
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
      @owner = User.find(Trip.find(@application.trip_id).user_id).profile
   end
   
   def destroy
      @application.destroy
      redirect_to trip_trip_applications_path
   end
   
   def index
      @applications = TripApplication.where("trip_id = ?", params[:trip_id])
   end
   
   def accept
      if !(@application.accepted || @application.declined)
         @application.accepted = true
         redirect_to trip_trip_applications_path(trip_id: @application.trip_id)
      end
   end 
   
   def deny
      if !(@application.accepted || @application.declined)
         @application.declined = true
         redirect_to trip_trip_applications_path(trip_id: @application.trip_id)
      end
   end 
   
   private
         def set_application
            @application = TripApplication.find(params[:id]) 
         end
         
         def application_params
           params.require(:trip_application).permit(:seat_total, :max_price_per_seat, :details, :user_id, :trip_id) 
         end
end