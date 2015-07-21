class SessionsController < ApplicationController
  def new

  end
  def create
    email = params[:session][:email]
    password = params[:session][:password]
    @user = User.find_by(email: email)

    # authenticate returns user object if password mathces and false otherwise
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end

    p "$"*99
    p session
    p "$"*99

  end

end
