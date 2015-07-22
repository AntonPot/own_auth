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
      flash[:notice] = 'User has been successfuly created'
      redirect_to '/'
    else
      redirect_to '/signup'
      flash[:notice] = @user.errors.messages
    end
  end

  def edit
    @user = current_user
  end

  def update
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

  def destroy
    user = User.find(params[:id])
    session[:user_id] = nil
    user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :email_confirmation, :username, :password, :password_confirmation)
  end
end
