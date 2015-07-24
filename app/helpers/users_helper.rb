module UsersHelper

  def user_full_name(user = current_user)
    "#{user.first_name} #{user.last_name}"
  end

  def user_first_name(user = current_user)
    user.first_name
  end

end
