require 'rails_helper'

RSpec.describe Post do
  let(:test_user) { User.create(name: 'Example User', email: 'test@example.com', password: 'password') }
  let(:subject) do
    described_class.new(
      content: 'new job offer',
      user_id: test_user.id
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a content' do
      subject.content = nil
      expect(subject).to_not be_valid
    end

    it 'Content cannot be longer than 1,000' do
      subject.content = '0' * 1001
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations', type: :model do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end
