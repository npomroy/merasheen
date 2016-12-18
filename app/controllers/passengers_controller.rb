class PassengersController < ApplicationController
   def new
      @passenger = Passenger.new 
   end
   
   def create
      @passenger = Passenger.new(passenger_params)
      @passenger.user_id = current_user.id
      if @passenger.save
          flash[:success] = "Passenger created"
          redirect_to root_path
      else
          flash[:error] = "Passenger creation failed"
          render action: :new
      end
   end
   
   private
        def passenger_params
           params.require(:passenger).permit(:title, :earliestdate, :latestdate, :details, :user_id) 
        end
end