class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # this allows helper to be used in view
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # this is a controller helper method
  def sign_in_as(user)
    session[:user_id] = user.id
  end

  def sign_out!
    session.clear
  end
end
