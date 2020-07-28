class UsersController < ApplicationController
  before_action :authenticate_user!
  include FriendshipHelper
  def index
    @users = User.all
    @confirmed_friends = friend_search { |friend| friend[1] == true }
    @pending_friends = friend_search { |friend| friend[1].nil? }
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @confirmed_friends = friend_search { |friend| friend[1] == true }
    @pending_friends = friend_search { |friend| friend[1].nil? }
    @show_friend = friend_search(@user) { |friend| friend[1] == true }
    @mutual_friend = find_mutual_friend
  end
end
