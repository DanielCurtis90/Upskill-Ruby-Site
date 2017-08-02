class UsersController < ApplicationController
  # This is from Devise. It checks that there is a user logged in to run these
  # actions. We dont want non-users looking at users!
  before_action :authenticate_user!
  
  def index
    
  end
  
  # GET to /users/:id
  # Note that it's now :id instead of :user_id that we used in the nested routes
  def show
    @user = User.find( params[:id] )
  end
end