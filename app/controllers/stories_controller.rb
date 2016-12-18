class StoriesController < ApplicationController
   def new
      @story = Storie.new 
   end
   
   def create
      @story = Storie.new(story_params)
      @story.user_id = current_user.id
      if @story.save
          flash[:success] = "Story created"
          redirect_to root_path
      else
          flash[:error] = "Story creation failed"
          redner action: :new
      end
   end
   
   private
        def story_params
            params.require(:storie).permit(:user_id, :title, :location, :date, :description)
        end
end