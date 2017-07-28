class ProfilesController < ApplicationController
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
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  
  private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
  end
end