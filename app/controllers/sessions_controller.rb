class SessionsController < ApplicationController
  def new

  end
  def create
    email = params[:session][:email]
    @user = User.find_by(email: email)

    p "$"*99
    p @user
    p "$"*99
  end
end
