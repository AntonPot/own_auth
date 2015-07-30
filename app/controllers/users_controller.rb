class UsersController < ApplicationController

  def index
    @users = User.all
    @surveys = current_user.surveys if current_user
  end

  def new
    @user = User.new
  end

  def google_callback
    if google_user_data
      user = User.where(google_uid: google_user_data["uid"]).first
      user ||= create_user_from_google google_user_data
      sign_in_as user
      redirect_to root_path
    else
      flash[:notice] = "Something went wrong. Try creating an account."
      redirect_to signup_path
    end
  end

  def linkedin_callback
      # par = MultiJson.encode(request.env['omniauth.auth'])
      p "$"*99
      p linkedin_user_data
      redirect_to root_path, notice: 'LinkedIn Callback'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User has been successfuly created'
      # sign_in_as(@user)
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
      redirect_to root_path, notice: "Update successful"
    else
      redirect_to edit_user_path, notice: user.errors.messages
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
