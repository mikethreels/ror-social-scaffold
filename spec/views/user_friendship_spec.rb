require 'rails_helper'

# rspec spec/views/user_spec.rb
RSpec.describe 'Main flow', type: :system do
  describe 'New user' do
    let(:test_friend) { User.create(name: 'Friend Test', email: 'friend@example.com', password: 'password') }
    it 'User path is correct' do
      test_friend
      # Access Home Page
      visit('/')

      # Go to Sign Up page
      click_link('Sign up')

      # Sign up
      sleep 1
      fill_in('user[name]', with: 'Test')
      fill_in('user[email]', with: 'test@email.com')
      fill_in('user[password]', with: 'password')
      fill_in('user[password_confirmation]', with: 'password')
      sleep 1
      click_button('Sign up')

      # Go to Create New Event page
      sleep 1
      click_link('All users')

      # Request a new friend
      sleep 1
      click_button('invite')

      # Logout
      sleep 1
      click_link('Sign out')

      # Login as the friend
      sleep 1
      fill_in('user[email]', with: 'friend@example.com')
      fill_in('user[password]', with: 'password')
      click_button('Log in')
      sleep 1

      # Check my invitations
      click_link('My invitations')
      sleep 1
      click_button('Accept')
      sleep 1

      # Logout friend
      click_link('Sign out')
    end
  end
end
