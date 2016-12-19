class PassengersController < ApplicationController
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
end