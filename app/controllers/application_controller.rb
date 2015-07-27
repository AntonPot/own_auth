class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # this allows helper to be used in view
  helper_method :current_user

  # find_by! raises an error when user isn't found
  def current_user
    @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end

  # this is a controller helper method
  def sign_in_as(user)
    cookies[:auth_token] = user.auth_token
  end

  def sign_out!
    session.clear
  end

  def user_data
    request.env['omniauth.auth'].to_hash
  end

  def create_user_from_google(user_data)
    user = User.new
    user.first_name = user_data["info"]["first_name"]
    user.last_name = user_data["info"]["last_name"]
    user.email = user_data["info"]["email"]
    user.image = user_data["info"]["image"]
    user.google_uid = user_data["uid"]
    user.email_confirmation = user_data["info"]["email"]
    user.password = SecureRandom.hex(9) # need to find better solution
    user.save!
    user
  end
end
