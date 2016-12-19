class LogsController < ApplicationController
   def new
       @log = Log.new
   end
   
   def edit
      @log = Log.find(params[:id]) 
   end
   
   def create
      @log = Log.new( log_params )
      @log.user_id = current_user.id
      @log.likes = 0
      if @log.save
          flash[:success] = "Log added"
          redirect_to logs_path
      else
          flash[:error] = 'Log creation failed'
          render action: :new
      end
   end
   
   def show
      @log = Log.find(params[:id]) 
      @profile = Profile.find_by(user_id: @log.user_id)
   end
   
   def update
      @log = Log.find(params[:id])
      if @log.update_attributes(log_params)
          flash[:success] = "Log updated"
          redirect_to logs_path
      else
          flash[:error] = "Log update failed"
          render action: :show
      end
   end
   
   def destroy
      Log.find([:id]).destroy
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
end