class PagesController < ApplicationController 
    # GET request for / which is our home page
    def home
      #These instance variables save the details of the default basic and pro 
      #plans in the database so we can use them in the view file
      @basic_plan = Plan.find(1)
      @pro_plan = Plan.find(2)
    end
    
    def about
    end
    
end