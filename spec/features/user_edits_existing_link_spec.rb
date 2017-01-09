require 'rails_helper'

describe 'edit links', :js => :true do
  let(:user) {create_user}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    create_link(user)
  end

  context 'Authenticated user can edit an existing link' do
    it 'enters valid URL and title for link and updates it' do
      visit '/'
      within('.link_buttons') {click_link 'Edit'}
      fill_in 'link_url', with: 'http://new.com'
      fill_in 'link_title', with: 'NEW'
      click_on 'Update Link'

      expect(page).to have_content('Link Successfully Updated')
      expect(Link.last.url).to eq('http://new.com')
      expect(Link.last.title).to eq('NEW')
    end

    it 'enters invalid URL for link and is rejected' do
      visit '/'
      within('.link_buttons') {click_link 'Edit'}
      fill_in 'link_url', with: 'new.com'
      click_on 'Update Link'

      expect(page).to have_content('Invalid URL. Please enter a valid web address.')
      expect(Link.last.url).to eq('http://test.com')
      expect(Link.last.title).to eq('test')
    end
  end
end
