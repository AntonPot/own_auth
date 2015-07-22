module SessionsHelper
  # this is a view helper method
  def logged_in?
    !!current_user
  end

end
