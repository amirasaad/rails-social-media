class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  protected
  def current_user
  	remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  helper_method :current_user
  def authenticate
  	logged_in? || access_denied
  end

  def logged_in?
  	!current_user.nil?
  end
  helper_method :logged_in?
  def access_denied
    store_location
    redirect_to login_path, notice: "Please log in to continue."
    return false
  end

  def current_user?(user)
    return current_user == user
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
