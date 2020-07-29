module FriendshipHelper
  def find_mutual_friend
    @show_friend.select do |friend|
      @confirmed_friends.include?(friend[0])
    end.uniq
  end

  def find_friendship_id(user_id)
    current_user.inverted_friendships.find_by(user_id: user_id).id
  end

  def invite_button(user_id)
    button = (button_to 'invite', friendships_path, method: :post, params: { friend_id: user_id }).html_safe
    return button unless (@confirmed_friends + @pending_friends).include?(user_id) || current_user.id == user_id
  end
end
