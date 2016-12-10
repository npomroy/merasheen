class BoatsController < ApplicationController
    # GET /boats/new
    def new
        @boat = Boat.new
    end
    
    # GET /boats/:id
    def show
       @boat = Boat.find(params[:id]) 
    end
    
    # POST /boats
    def create
        @boat = Boat.new( boat_params )
        if @boat.save
            flash[:success] = "Boat created"
            redirect_to new_boat_path
        else
            flash[:error] = "Creation failed"
            redirect_to new_boat_path
        end
    end
    
    # GET /boats/:id/edit
    def edit
       @boat = Boat.find(params[:id]) 
    end
    
    # GET /boats
    def index
       @boats = Boat.all 
    end
    
    private
        def boat_params
           params.require(:boat).permit(:name, :owner, :home_port, :capacity, :price, :speed, :avatar, :comments) 
        end
end