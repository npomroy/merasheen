class LogsController < ApplicationController
   def new
       @log = Log.new
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
   
   def destroy
      Log.find([:id]).destroy
      redirect_to logs_path
   end
   
   def index
      @logs = Log.all 
   end
   
   private
        def log_params
            params.require(:log).permit(:title, :user_id, :link, :details, :startdate, :enddate, :likes)
        end
end