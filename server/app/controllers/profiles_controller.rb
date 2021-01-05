class ProfilesController < ApplicationController
  before_action :authenticate_user!

  before_action :get_profile, only: [:edit, :update]


  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html {
          redirect_to '/settings', notice: 'Profile was successfully updated.'
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json {
          render json: @profile.errors, status: :unprocessable_entity
        }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:name).permit(:birthday)
  end

  def get_profile
    @profile = current_user.profile || Profile.new
    @profile.user = current_user
  end


end
