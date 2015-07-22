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
      flash[:notice] = 'Password or email is incorrect'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end

end
