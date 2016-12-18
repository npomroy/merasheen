class StoriesController < ApplicationController
   def new
      @storie = Storie.new 
   end
end