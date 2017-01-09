require 'rails_helper'

describe 'Existing user logs in' do
  before(:each) do
    create_user
  end

  context 'enters information' do
    it 'fills in correct info and logs in' do
      visit '/'
      click_on 'Login'

      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'password'
      within('.new_user') {click_on 'Login'}

      expect(page).to have_content('Successfully Logged In')
      expect(page).to have_content('Welcome, test@test.com')
      expect(current_path).to eq(root_path)
    end

    it 'fills in incorrect email address and is rejected' do
      visit '/'
      click_on 'Login'

      fill_in 'user_email', with: 'tes@test.com'
      fill_in 'user_password', with: 'password'
      within('.new_user') {click_on 'Login'}

      expect(page).to have_content('Email And/ Or Password Were Incorrect')
      expect(page).to_not have_content('Welcome, test@test.com')
    end

    it 'fills in incorrect password and is rejected' do
      visit '/'
      click_on 'Login'

      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'passwod'
      within('.new_user') {click_on 'Login'}

      expect(page).to have_content('Email And/ Or Password Were Incorrect')
      expect(page).to_not have_content('Welcome, test@test.com')
    end
  end
end
