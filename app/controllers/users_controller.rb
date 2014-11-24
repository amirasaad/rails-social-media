class UsersController < ApplicationController
  before_action :authenticate, only: [:edit, :update]
  before_action :set_user, only: [:edit ,:update, :destroy]
  before_action :admin_user, only: :destroy
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    @user.build_profile
    if @user.save
      sign_in @user
      redirect_to "/#{@user.username}", notice: 'You successfully registered.'
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
    @followed_users = @user.followed_users.paginate(page: params[:page])
    @followers = @user.followers.paginate(page: params[:page])
  end

  def update
    if @user == current_user && @user.update(user_params)
      redirect_to posts_path, notice: 'User updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username ,:email, :password, :password_confirmation)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
