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
  end
end
