require 'rails_helper'

describe 'User logs in', :js => :true do
  context 'creates account' do
    it 'fills in necessary fields' do
      visit '/'
      click_on 'Sign Up'

      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'

      click_on 'Create Account'

      expect(page).to have_content('Account Successfully Created')
      expect(page).to have_content('Welcome, test@test.com')
    end

    it 'does not fill in email address and is rejected' do
      visit '/'
      click_on 'Sign Up'

      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'

      click_on 'Create Account'

      expect(page).to have_content("Email can't be blank")
      expect(current_path).to eq('/users')
    end

    it 'does not fill in password and is rejected' do
      visit '/'
      click_on 'Sign Up'

      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password_confirmation', with: 'password'

      click_on 'Create Account'

      expect(page).to have_content("Password can't be blank")
      expect(current_path).to eq('/users')
    end

    it 'does not fill in password confirm and is rejected' do
      visit '/'
      click_on 'Sign Up'

      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'password'

      click_on 'Create Account'

      expect(page).to have_content("Password confirmation can't be blank")
      expect(current_path).to eq('/users')
    end

    it 'fills in different passwords and is rejected' do
      visit '/'
      click_on 'Sign Up'

      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: '123456'

      click_on 'Create Account'

      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(current_path).to eq('/users')
    end
  end
end
