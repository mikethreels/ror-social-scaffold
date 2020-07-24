class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @confirmed_friends = friend_search {|friend| friend[1] == true }
    @pending_friends = friend_search {|friend| friend[1].nil? }
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @confirmed_friends = friend_search {|friend| friend[1] == true }
    @pending_friends = friend_search {|friend| friend[1].nil? }
  end

  def invite
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])
    redirect_back(fallback_location: root_path) 
  end

  def invitation
    @users = User.all
    all_invitations = current_user.reverse_friendships.pluck(:user_id, :status)
    @pending_invitations = []
    all_invitations.select do |friend|
      if friend[1].nil?
        @pending_invitations << friend[0] 
      end
    end
    @pending_invitations
  end

  def accept
    current_user.reverse_friendships.find_by(user_id: params[:friend_id]).update(status: true)
    redirect_back(fallback_location: root_path) 
  end

  def ignore
    current_user.reverse_friendships.find_by(user_id: params[:friend_id]).destroy
    redirect_back(fallback_location: root_path)   
  end




end
