class SessionsController < ApplicationController
	def create
		if user = User.authenticate(params[:username], params[:password])
			sign_in user
			redirect_back_or user
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
