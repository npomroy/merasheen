class StoriesController < ApplicationController
   before_action :set_story, only: [:show, :edit, :update, :destroy]
   before_action :only_with_names, only: [:new, :create, :edit, :update, :destroy]
   before_action :only_owner, only: [:edit, :update, :destroy]
    
   def new
      @story = Storie.new 
   end
   
   def edit
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
      @profile = Profile.find_by(user_id: @story.user_id)
   end
   
   def update
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
      @story.destroy
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
        
        def set_story
           @story = Storie.find(params[:id])
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
           redirect_to story_path(id: params[:id]) unless @story.user_id == current_user.id
        end
end