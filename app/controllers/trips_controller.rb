class TripsController < ApplicationController
    def new
       @trip = Trip.new
    end
    
    # POST /trips
    def create
       @trip = Trip.new( trip_params )
       if @trip.save
           flash[:success] = "Trip created"
           redirect_to new_trip_path
       else
           flash[:error] = "Trip Creation Failed"
           redirect_to new_trip_path
       end
    end
    
    # GET /trips
    def index
       @trips = Trip.all 
    end
    
    private
        def trip_params
           params.require(:trip).permit(:name, :depart_from, :depart_date_time, :boat_id, :skipper, :available_seats, :starting_price, :comments) 
        end
end