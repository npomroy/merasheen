class StoriesController < ApplicationController
   before_action :only_with_names, only: [:new, :create, :edit, :update, :destroy]
   before_action :only_owner, only: [:edit, :update, :destroy]
    
   def new
      @story = Storie.new 
   end
   
   def edit
      @story = Storie.find(params[:id]) 
   end
   
   def create
      @story = Storie.new(story_params)
      @story.user_id = current_user.id
      @story.likes = 0
      @story.date = Date.civil(params[:date][:year].to_i, params[:date][:month].to_i,
                                 params[:date][:day].to_i)
      if @story.save
          flash[:success] = "Story created"
          redirect_to stories_path
      else
          flash[:error] = "Story creation failed"
          redner action: :new
      end
   end
   
   def show
      @story = Storie.find(params[:id]) 
      @profile = Profile.find_by(user_id: @story.user_id)
   end
   
   def update
      @story = Storie.find(params[:id])
      @story.date = Date.civil(params[:date][:year].to_i, params[:date][:month].to_i,
                                 params[:date][:day].to_i)
      if @story.update_attributes(story_params)
          flash[:success] = "Story updated"
          redirect_to storie_path(id: params[:id])
      else
          flash[:error] = "Story update failed"
          render action: :show
      end
   end
   
   def destroy
      Storie.find(params[:id]).destroy
      redirect_to stories_path
   end
   
   def index
      @stories = Storie.all 
      @profiles = Profile.all
   end
   
   private
        def story_params
            params.require(:storie).permit(:user_id, :title, :location, :date, :description)
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
           redirect_to story_path(id: params[:id]) unless @story.user_id == current_user.id
        end
end