class PassengersController < ApplicationController
   def new
      @passenger = Passenger.new 
   end
end