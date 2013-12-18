class UsersController < ApplicationController
	before_action :authenticate, only: [:edit, :update]
	before_action :set_user, only: [:edit ,:update, :destroy]


	def new
		@user = User.new

	end
	def create 
		@user = User.new(user_params)
		@profile = Profile.new 
		@profile.save
		if @user.save && @profile.save
			redirect_to edit_user_profile_path(@user), notice: 'You successfully registered.'
		else 
			render action: :new
		end
	end

	def edit
	end

	def show

		
		@user ||= User.find(params[:username]) 
		@posts = @user.posts
		@profile = @user.profile
	end

	def update
		if @user.update(user_params)
			redirect_to posts_path, notice: 'User updated'
		else
			render action: 'edit'
		end
	end

	private
	def set_user
		@user = User.find(user_params[:id])
	end

	def user_params
		params.require(:user).permit(:username ,:email, :password, :password_confirmation)
	end
end
