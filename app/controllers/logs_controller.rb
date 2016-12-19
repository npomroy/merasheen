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
      @log = Log.find(params[:id]) 
      @profile = Profile.find_by(user_id: @log.user_id)
   end
   
   def update
      @log = Log.find(params[:id])
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