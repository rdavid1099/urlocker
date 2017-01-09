require 'rails_helper'

describe 'Existing user logs in' do
  context 'enters information' do
    it 'fills in correct info and logs in' do
      create_user

      visit '/'
      click_on 'Login'

      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'password'
      within('.new_user') {click_on 'Login'}

      expect(page).to have_content('Successfully Logged In')
      expect(page).to have_content('Welcome, test@test.com')
      expect(current_path).to eq(root_path)
    end
  end
end
