class SessionsController < ApplicationController
  include SessionsHelper
  def create
    if user = User.authenticate(
        params[:login][:username], params[:login][:password]
      )

      sign_in user
      redirect_to root_path, :notice => "Welcome #{user.username}!"
    else
      flash.now[:alert] = "Invalid login/password combination"
      render :action => 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path, :notice => "You successfully logged out"
  end

end
