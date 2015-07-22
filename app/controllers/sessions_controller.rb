class SessionsController < ApplicationController

  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    @user = User.find_by(email: email)
    # authenticate returns user object if password mathces and false otherwise
    if @user && @user.authenticate(password)
      sign_in_as(@user)
      redirect_to '/'
    # elsif user_data
    #   p "#"*99
    #   p user_data
    else
      flash[:notice] = 'Password or email is incorrect'
      redirect_to '/login'
    end
  end

  def destroy
    sign_out!
    redirect_to "/"
  end

end
