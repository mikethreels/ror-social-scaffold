require 'rails_helper'

RSpec.describe Friendship do
  let(:test_user) { User.create(name: 'Example User', email: 'test@gmail.com', password: 'password') }
  let(:test_friend) { User.create(name: 'Example Friend', email: 'friend@gmail.com', password: 'password') }

  let(:subject) do
    test_user
    test_friend
    described_class.new(
      user_id: test_user.id,
      friend_id: test_friend.id
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a user' do
      subject.user_id = ''
      expect(subject).to_not be_valid
    end

    it 'is not valid without a friend' do
      subject.friend_id = ''
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations', type: :model do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end
