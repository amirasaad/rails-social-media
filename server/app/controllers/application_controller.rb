class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #has to be after auto_session_timeout so that prepend will not be overwritten.
  protect_from_forgery with: :exception, prepend: true

  helper_method :current_user

  private

  def current_user
    @current_user ||= authenticate_by_session(User)
  end

  def require_user!
    return if current_user
    redirect_to root_path, flash: { error: 'You are not worthy!' }
  end

end
