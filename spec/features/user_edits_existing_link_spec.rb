require 'rails_helper'

describe 'edit links', :js => :true do
  let(:user) {create_user}

  context 'Authenticated user can edit an existing link' do
    it 'enters valid URL for link and creates it' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      orig_link = create_link(user)

      visit '/'
      within('.link_buttons') {click_link 'Edit'}
      fill_in 'link_url', with: 'http://new.com'
      fill_in 'link_title', with: 'NEW'
      click_on 'Update Link'

      within('#links-list') do
        expect(page).to have_content('NEW')
        expect(page).to have_content('http://new.com')
        expect(page).to have_content('Link Successfully Updated')
        expect(page).to_not have_content(orig_link.url)
        expect(page).to_not have_content(orig_link.title)
      end
    end
  end
end
