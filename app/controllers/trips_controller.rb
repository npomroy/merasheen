class TripsController < ApplicationController
    before_action :only_with_names, only: [:new, :create, :edit, :update, :destroy]
    before_action :only_owner, only: [:edit, :update, :destroy]
    
    # GET /trips/new
    def new
       @trip = Trip.new
    end
    
    # GET /trips/:id
    def show
       @trip = Trip.find(params[:id])
       @boat = Boat.find(@trip.boat_id)
    end
    
    # POST /trips
    def create
       @trip = Trip.new( trip_params )
       @trip.user_id = current_user.id
       @trip.depart_date_time = DateTime.civil(params[:depart_date_time][:year].to_i, 
                        params[:depart_date_time][:month].to_i, params[:depart_date_time][:day].to_i,
                        params[:depart_date_time][:hour].to_i, params[:depart_date_time][:minute].to_i,
                        params[:depart_date_time][:seconds].to_i)
       if @trip.save
           flash[:success] = "Trip created"
           redirect_to trips_path
       else
           flash[:error] = "Trip Creation Failed"
           render action: :new
       end
    end
    
    # GET /trips/:id/edit
    def edit
       @trip = Trip.find(params[:id]) 
    end
    
    # PUT /trips/:id
    def update
       @trip = Trip.find(params[:id])
       if @trip.update_attributes( trip_params )
           flash[:success] = "Trip updated"
           redirect_to trip_path(id: params[:id])
       else
           flash[:error] = "Update failed"
           render :edit
       end
    end
    
    # GET /trips
    def index
       @trips = Trip.all 
       @boats = Boat.select("id, name").to_a()
    end
    
    private
        def trip_params
           params.require(:trip).permit(:name, :depart_from, :depart_date_time, :boat_id, :skipper, :available_seats, :starting_price, :comments) 
        end
        
        def only_with_names
            if current_user.profile
                flash[:error] = "Profile must include first and last name"
                redirect_to edit_user_profile_path(user_id: current_user.id) unless current_user.first_name && current_user.last_name
            else
                flash[:error] = "Must have profile"
                redirect_to new_user_profile_path(user_id: current_user.id) unless current_user.profile
            end
        end
        
        def only_owner
           redirect_to trip_path(id: params[:id]) unless @trip.user_id == current_user.id
        end
end