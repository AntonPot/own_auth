class UsersController < ApplicationController

  def index
    @users = User.all
    @surveys = current_user.surveys if current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/'
    else
      redirect_to '/signup'
      p "@"*99
      p @user.errors.messages
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end
end
