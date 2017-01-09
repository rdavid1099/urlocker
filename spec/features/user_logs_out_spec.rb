require 'rails_helper'

describe 'Existing user logs in and logs out' do
  before(:each) do
    create_user
  end

  it 'clicks logout to log out' do
    visit '/'
    click_on 'Login'

    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'password'
    within('.new_user') {click_on 'Login'}

    click_on 'Logout'

    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Login')
    expect(page).to_not have_content('Welcome, test@test.com')
  end
end
