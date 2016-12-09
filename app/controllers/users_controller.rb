class UsersController < ApplicationController
   # GET to /users/:id
   def show
      @user = current_user 
   end
end