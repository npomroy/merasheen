class LogsController < ApplicationController
   def new
       @log = Log.new
   end
end