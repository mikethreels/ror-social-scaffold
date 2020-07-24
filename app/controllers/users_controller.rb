class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    confirmed_friends
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    confirmed_friends
  end

  def confirmed_friends
    @friend_arr = current_user.friendships.pluck(:friend_id, :status) + current_user.reverse_friendships.pluck(:user_id, :status)
    @temp = []
    @friend_arr.select do | i |
      if i[1] == true || i[1].nil?
        @temp << i[0] 
      end
    end
    @temp
  end

  def invite
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])
    redirect_back(fallback_location: root_path) 
  end
end
