class TripApplicationsController < ApplicationController
   before_action :set_application, only: [:show, :destroy, :accept, :deny]
   before_action :only_owner, only: [:accept, :deny]
   before_action :only_owner_or_poster, only: [:show]
   
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
      redirect_to applications_path
   end
   
   def index
      @applications = TripApplication.where("owner_id = ?", current_user.id)
   end
   
   def accept
      if !(@application.accepted || @application.declined)
         @application.accepted = true
         if @application.save
             flash[:success] = "Application accepted"
         else
             flash[:error] = "Accept failed"
         end
         redirect_to applications_path
      end
   end 
   
   def deny
      if !(@application.accepted || @application.declined)
         @application.declined = true
         if @application.save
             flash[:success] = "Application denied"
         else
             flash[:error] = "Deny failed"
         end
         redirect_to applications_path
      end
   end 
   
   private
         def set_application
            if params[:id]
               @application = TripApplication.find(params[:id]) 
            else
               @application = TripApplication.find(params[:trip_application_id])
            end
         end
         
         def only_owner
            redirect_to applications_path unless @application.owner_id == current_user.id
         end
         
         def only_owner_or_poster
            redirect_to applications_path unless (@application.owner_id == current_user.id || @application.user_id == current_user.id)
         end
         
         def application_params
           params.require(:trip_application).permit(:seat_total, :max_price_per_seat, :details, :user_id, :trip_id) 
         end
end