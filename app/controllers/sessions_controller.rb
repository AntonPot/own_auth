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
      if params[:remeber_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      p "$"*99
      p params
      p "$"*99
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    # session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to "/"
  end

end
