# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user!, only: %i[edit update]
  before_action :set_user, only: %i[edit update destroy]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_to root_path, flash: { notice: 'Nwartt! <3' }
    else
      render :new
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def edit; end

  def show
    @user ||= User.find(params[:username])
    @posts = @user.posts
    @profile = @user.profile
    @followed_users = @user.followed_users.paginate(page: params[:page])
    @followers = @user.followers.paginate(page: params[:page])
  end

  def update
    if @user == current_user
      redirect_to edit_user_path, notice: 'alsta'
    else
      render action: 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to people_path
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow', locals: {user: @user}
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow', locals: {user: @user}
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user == @user
  end
end
