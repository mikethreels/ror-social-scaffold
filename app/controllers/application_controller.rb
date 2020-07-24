class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def friend_search
    all_friend_arr = current_user.friendships.pluck(:friend_id, :status) + current_user.reverse_friendships.pluck(:user_id, :status)
    temporary_friends = []
    all_friend_arr.select do | friend |
      if yield(friend)
        temporary_friends << friend[0] 
      end
    end
    temporary_friends
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
end
