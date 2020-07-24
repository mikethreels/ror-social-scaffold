class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    confirmed_friends
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def confirmed_friends
    @friend_arr = current_user.friendships.pluck(:friend_id, :status) + current_user.reverse_friendships.pluck(:user_id, :status)
    @friend_arr.select! do | i |
      i.pop if i[1] == true
    end
    @friend_arr.flatten!
  end
  def invite

  end
end
