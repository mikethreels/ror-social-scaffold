class UsersController < ApplicationController
  before_action :authenticate_user!
  include FriendshipHelper

  def index
    @users = User.all
    @confirmed_friends = current_user.friends.pluck(:friend_id)
    @pending_friends = current_user.pending_friends.pluck(:friend_id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @confirmed_friends = current_user.friends.pluck(:friend_id)
    @pending_friends = current_user.pending_friends.pluck(:friend_id)
    @show_friend = @user.friends.pluck(:friend_id, :name)
    @mutual_friend = find_mutual_friend
  end
end
