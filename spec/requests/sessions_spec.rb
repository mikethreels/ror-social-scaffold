require 'rails_helper'

RSpec.describe User do
  describe 'GET /users/sign_in' do
    it 'should show the login page' do
      get new_user_session_path
      expect(response).to be_successful
      expect(response).to render_template('devise/sessions/new')
    end
  end

  describe 'GET /users/sign_up' do
    it 'should show the signup page' do
      get new_user_registration_path
      expect(response).to be_successful
      expect(response).to render_template('devise/registrations/new')
    end
  end
end
