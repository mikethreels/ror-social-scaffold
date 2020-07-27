require 'rails_helper'

RSpec.describe Comment do
  let(:test_user) { User.create(name: 'Example User', email: 'test@example.com', password: 'asiodjhaiosdjf') }
  let(:test_post) { Post.create(content: 'This is a test post', user_id: test_user.id) }
  let(:subject) do
    described_class.new(
      post_id: test_post.id,
      user_id: test_user.id,
      content: 'This is a test comment'
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'The content of the comment should exist' do
      subject.content = ''
      expect(subject).to_not be_valid
    end

    it 'The content of the comment should not be longer than 200 characters' do
      subject.content = '0' * 205
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations', type: :model do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
