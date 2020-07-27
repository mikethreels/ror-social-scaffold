module FriendshipHelper

    def friend_search
        all_friend_arr = current_user.friendships.pluck(:friend_id, :status) + current_user.reverse_friendships.pluck(:user_id, :status)
        temporary_friends = []
        all_friend_arr.select do |friend|
          temporary_friends << friend[0] if yield(friend)
        end
        temporary_friends
      end

    def find_friendship_id(user_id)
        current_user.reverse_friendships.find_by(user_id: user_id).id
    end
end
