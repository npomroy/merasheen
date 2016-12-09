class ProfilesController < ApplicationController
   # GET to /users/:user_id/profile/new
   def new
      # Render blank profile details form
      @profile = Profile.new
   end
   
   # POST to /users/:user_id/profile
   def create
      # Ensure that we have the user who is filling out form
      @user = current_user
      # Create profile linked to this specific user
      @profile = @user.build_profile( profile_params )
      if @profile.save
          flash[:success] = "Profile updated"
          redirect_to user_path( current_user.id )
      else
          render action: :new
      end
   end
   
   # PUT to /users/:user_id/profile/edit
   def edit
      @profile = current_user.profile 
   end
   
   private
    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :avatar, :description, :boat_id)
    end
end