class FriendshipsController < ApplicationController
  def invitation
    @users = User.all
    all_invitations = current_user.reverse_friendships.pluck(:user_id, :status)
    @pending_invitations = []
    all_invitations.select do |friend|
      @pending_invitations << friend[0] if friend[1].nil?
    end
    @pending_invitations
  end

  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])
    redirect_back(fallback_location: root_path)
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(status: true)
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
