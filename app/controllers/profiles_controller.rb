class ProfilesController < ApplicationController
  # This is from Devise. It checks that there is a user logged in to run these
  # actions. Note that before actions can be limited i.e only [:new]
  before_action :authenticate_user!
  # We need to define this one down below in Private
  before_action :only_current_user
  
  
  # GET to /users/:user_id/profile/new
  def new
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
  # Ensure that we have the user who is filling out form
  @user = User.find( params[:user_id] )
  # Create profile linked to this specific user
  # The user object has this build method due to the association between it and
  # the profile object
  # Use .build instead of .new when you want a relationship between the two
  # objects!!!
  @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      # The user_path uses :id, however the query string parameter from the 
      # profiles page is using :user_id, so that's where the parameter is found
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :new
    end
  end
  
  # GET to /users/:user_id/profile/edit
  def edit
    # Grab the user from the ID in the URL, then stick their profile data 
    # into the form
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end  
  
  # PUT to /users/:user_id/profile
  def update
    # Retrieve the user from the database
    # Grab the user from the ID in the URL, then stick their profile data 
    # into the form
    @user = User.find( params[:user_id] )
    # Retrieve that users profile into the form fields
    @profile = @user.profile
    # Mass assign edited profile attributes and save (update)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      # Redirect user to their profile page
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
  
    def only_current_user
      @user = User.find( params[:user_id] )
      # Move them to the home page if they aren't they dont match the profile ID
      redirect_to(root_url) unless @user == current_user
    end
end