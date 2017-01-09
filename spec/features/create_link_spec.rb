require 'rails_helper'

describe 'create links', :js => :true do
  let(:user) {create_user}

  context 'Authenticated user can create a new link' do
    it 'enters valid URL for link and creates it' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'
      fill_in 'Title:', with: 'Turing'
      fill_in 'URL:', with: 'http://turing.io'
      click_on 'Add Link'

      within('#links-list') do
        expect(page).to have_text('Turing')
        expect(page).to have_text('http://turing.io')
        expect(page).to have_content('Read?')
        expect(page).to have_content('false')
      end
    end

    it 'enters invalid URL for link and is rejected' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'
      fill_in 'Title:', with: 'Turing'
      fill_in 'URL:', with: 'blahblabh.test.dumb.url.or.is.it.uri?'
      click_on 'Add Link'

      expect(page).to have_content('Invalid URL. Please enter a valid web address.')
      within('#links-list') do
        expect(page).to_not have_content('Turing')
      end
    end
  end

  context 'Unauthenticated user can NOT create a new link' do
    it 'does not see a form for link creation' do
      visit '/'

      expect(page).to_not have_css('#new-link')
    end
  end
end
