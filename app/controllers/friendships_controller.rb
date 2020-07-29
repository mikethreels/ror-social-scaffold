class FriendshipsController < ApplicationController
  def invitation
    @users = User.all
    @pending_invitations = current_user.inverted_friendships.pluck(:user_id)
  end

  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])
    redirect_back(fallback_location: root_path)
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.confirm_friend
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:status)
  end
end
