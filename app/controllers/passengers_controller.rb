class PassengersController < ApplicationController
   before_action :only_with_names, only: [:new, :create, :edit, :update, :destroy]
   before_action :only_owner, only: [:edit, :update, :destroy]
    
   def new
      @passenger = Passenger.new 
   end
   
   def edit
      @passenger = Passenger.find(params[:id]) 
   end
   
   def create
      @passenger = Passenger.new(passenger_params)
      @passenger.user_id = current_user.id
      @passenger.earliestdate = DateTime.civil(params[:start_date][:year].to_i, 
                        params[:start_date][:month].to_i, params[:start_date][:day].to_i,
                        params[:start_date][:hour].to_i, params[:start_date][:minute].to_i,
                        params[:start_date][:seconds].to_i)
      @passenger.latestdate = DateTime.civil(params[:latest_date][:year].to_i, 
                        params[:latest_date][:month].to_i, params[:latest_date][:day].to_i,
                        params[:latest_date][:hour].to_i, params[:latest_date][:minute].to_i,
                        params[:latest_date][:seconds].to_i)
      if @passenger.save
          flash[:success] = "Passenger created"
          redirect_to passengers_path
      else
          flash[:error] = "Passenger creation failed"
          render action: :new
      end
   end
   
   def show
      @passenger = Passenger.find(params[:id]) 
   end
   
   def update
      @passenger = Passenger.find(params[:id])
      @passenger.earliestdate = DateTime.civil(params[:start_date][:year].to_i, 
                        params[:start_date][:month].to_i, params[:start_date][:day].to_i,
                        params[:start_date][:hour].to_i, params[:start_date][:minute].to_i,
                        params[:start_date][:seconds].to_i)
      @passenger.latestdate = DateTime.civil(params[:latest_date][:year].to_i, 
                        params[:latest_date][:month].to_i, params[:latest_date][:day].to_i,
                        params[:latest_date][:hour].to_i, params[:latest_date][:minute].to_i,
                        params[:latest_date][:seconds].to_i)
      if @passenger.update_attributes(passenger_params)
          flash[:success] = "Lookin for Ride updated"
          redirect_to passengers_path
      else
          flash[:error] = "Update failed"
          render action: :show
      end
   end
   
   def destroy
      Passenger.find(params[:id]).destroy
      redirect_to passengers_path
   end
   
   def index
      @passengers = Passenger.all 
   end
   
   private
        def passenger_params
           params.require(:passenger).permit(:title, :earliestdate, :latestdate, :details, :user_id) 
        end
        
        def only_with_names
            if current_user.profile
                if current_user.profile.first_name && current_user.profile.last_name
                    
                else
                    redirect_to edit_user_profile_path(user_id: current_user.id)
                    flash[:error] = "Profile must include first and last name"
                end
            else
                redirect_to new_user_profile_path(user_id: current_user.id)
                flash[:error] = "Must have profile"
            end
        end
        
        def only_owner
           redirect_to passenger_path(id: params[:id]) unless @passenger.user_id == current_user.id
        end
end