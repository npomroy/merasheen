class LogsController < ApplicationController
    before_action :set_log, only: [:show, :edit, :update, :destroy]
   before_action :only_with_names, only: [:new, :create, :edit, :update, :destroy]
   before_action :only_owner, only: [:edit, :update, :destroy]
    
   def new
       @log = Log.new
   end
   
   def edit
   end
   
   def create
      @log = Log.new( log_params )
      @log.user_id = current_user.id
      @log.likes = 0
      @log.startdate = DateTime.civil(params[:startdate][:year].to_i, 
                        params[:startdate][:month].to_i, params[:startdate][:day].to_i,
                        params[:startdate][:hour].to_i, params[:startdate][:minute].to_i,
                        params[:startdate][:seconds].to_i)
      @log.enddate = DateTime.civil(params[:enddate][:year].to_i, 
                        params[:enddate][:month].to_i, params[:enddate][:day].to_i,
                        params[:enddate][:hour].to_i, params[:enddate][:minute].to_i,
                        params[:enddate][:seconds].to_i)
      if @log.save
          flash[:success] = "Log added"
          redirect_to logs_path
      else
          flash[:error] = 'Log creation failed'
          render action: :new
      end
   end
   
   def show
      @profile = Profile.find_by(user_id: @log.user_id)
   end
   
   def update
      @log.startdate = DateTime.civil(params[:startdate][:year].to_i, 
                        params[:startdate][:month].to_i, params[:startdate][:day].to_i,
                        params[:startdate][:hour].to_i, params[:startdate][:minute].to_i,
                        params[:startdate][:seconds].to_i)
      @log.enddate = DateTime.civil(params[:enddate][:year].to_i, 
                        params[:enddate][:month].to_i, params[:enddate][:day].to_i,
                        params[:enddate][:hour].to_i, params[:enddate][:minute].to_i,
                        params[:enddate][:seconds].to_i)
      if @log.update_attributes(log_params)
          flash[:success] = "Log updated"
          redirect_to logs_path
      else
          flash[:error] = "Log update failed"
          render action: :show
      end
   end
   
   def destroy
      @log.destroy
      redirect_to logs_path
   end
   
   def index
      @logs = Log.all 
      @users = Profile.all
   end
   
   private
        def log_params
            params.require(:log).permit(:title, :user_id, :link, :details, :startdate, :enddate, :likes)
        end
        
        def set_log
           @log = Log.find(params[:id]) 
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
           redirect_to log_path(id: params[:id]) unless @log.user_id == current_user.id
        end
end