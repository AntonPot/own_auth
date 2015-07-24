class SessionsController < ApplicationController

  def new
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by(email: email)
    # authenticate returns user object if password mathces and false otherwise
    if user && user.authenticate(password)
      # session[:user_id] = @user.id
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
        # p "$"*99
        # p "Saved in permanent: #{cookies.permanent[:auth_token] == user.auth_token}"
      else
        cookies[:auth_token] = user.auth_token
        # p "$"*99
        # p "Saved in regular: #{cookies[:auth_token] == user.auth_token}"
      end
      # p "$"*99
      # p params
      # p params[:remember_me]
      # p "$"*99
      # p "Saved in permanent: #{cookies.permanent[:auth_token] == user.auth_token}"
      # p "$"*99
      # p "Saved in regular: #{cookies[:auth_token] == user.auth_token}"
      # p "$"*99

      redirect_to '/', notice: "You're logged in..."
    else
      redirect_to '/login', notice: "Log in failed!"
    end
  end

  def destroy
    # session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to "/", notice: "You're logged out"
  end

end
