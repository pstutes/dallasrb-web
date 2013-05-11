class ProfilesController < ApplicationController
  #user must be signed in to edit the profile
  before_filter :authenticate_user!, except:[:index, :show]
  
  def index
    @profiles = Profile.non_organizers.order('sort_order asc').page(params[:page]).per(4)
  end

  def show
    @profile = Profile.find params[:id]
  end

  def edit
    verify_user!
  end

  def update
    verify_user!
    if @profile.update_attributes(params[:profile])
      redirect_to @profile, :notice => "Profile saved."
    else
      render :edit
    end
  end

  private

  #edit/update only current user's profile
  def verify_user!
    @profile = current_user.profile
  end
end
