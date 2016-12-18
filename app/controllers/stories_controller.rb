class StoriesController < ApplicationController
   def new
      @story = Storie.new 
   end
   
   def create
      @story = Storie.new(story_params)
      @story.user_id = current_user.id
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
   end
   
   def update
      @story = Storie.find(params[:id])
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
   end
   
   private
        def story_params
            params.require(:storie).permit(:user_id, :title, :location, :date, :description)
        end
end