class ProfilesController < ApplicationController
  def edit
  end
  def show
  end
  def update
    @user = current_user
    @profile = current_user.profile
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  
  
end


