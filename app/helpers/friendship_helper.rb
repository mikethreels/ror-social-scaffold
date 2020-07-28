module FriendshipHelper
  def friend_search(user = current_user)
    user_friends = user.friendships.pluck(:friend_id, :status)
    inverse_friends = user.reverse_friendships.pluck(:user_id, :status)

    all_friend_arr = user_friends + inverse_friends

    temporary_friends = []
    all_friend_arr.select do |friend|
      temporary_friends << friend[0] if yield(friend)
    end

    return temporary_friends if user == current_user

    friend_info = []
    temporary_friends.each do |id|
      friend_info << User.find_by(id: id)
    end
    friend_info
  end

  def find_mutual_friend
    @show_friend.select do |friend|
      @confirmed_friends.include?(friend.id)
    end
  end

  def find_friendship_id(user_id)
    current_user.reverse_friendships.find_by(user_id: user_id).id
  end

  def invite_button(user_id)
    button = (button_to 'invite', friendships_path, method: :post, params: { friend_id: user_id }).html_safe
    return button unless (@confirmed_friends + @pending_friends).include?(user_id) || current_user.id == user_id
  end
end
