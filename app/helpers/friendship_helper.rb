module FriendshipHelper
  def friend_search
    user_friends = current_user.friendships.pluck(:friend_id, :status)
    inverse_friends = current_user.reverse_friendships.pluck(:user_id, :status)

    all_friend_arr = user_friends + inverse_friends

    temporary_friends = []
    all_friend_arr.select do |friend|
      temporary_friends << friend[0] if yield(friend)
    end
    temporary_friends
  end

  def find_friendship_id(user_id)
    current_user.reverse_friendships.find_by(user_id: user_id).id
  end

  def invite_button(user_id)
    button = (button_to 'invite', friendships_path, method: :post, params: { friend_id: user_id }).html_safe
    return button unless (@confirmed_friends + @pending_friends).include?(user_id) || current_user.id == user_id
  end
end
