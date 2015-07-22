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
    p "$"*99
    p user_params
    if @user.save
      redirect_to '/'
    else
      redirect_to '/signup'
      p "@"*99
      p @user.errors.messages
    end
  end

  def edit
    @user = current_user
  end

  def update
    p "#"*99
    p user_params
    p "*"*99
    user = User.find(params[:id])
    user.assign_attributes(user_params)
    user.email_confirmation = user.email
    if user.save
      flash[:notice] = "Update successful"
      redirect_to root_path
    else
      flash[:notice] = user.errors.messages
      redirect_to edit_user_path
    end

  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :email_confirmation, :username, :password, :password_confirmation)
  end
end
