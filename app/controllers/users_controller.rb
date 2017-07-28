class UsersController < ApplicationController
  # GET to /users/:id
  # Note that it's now :id instead of :user_id that we used in the nested routes
  def show
    @user = User.find( params[:id] )
  end
end