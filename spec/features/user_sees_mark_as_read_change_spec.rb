require 'rails_helper'

describe 'marking as read changes style', :js => :true do
  let(:user) {create_user}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = create_link(user)
    allow(HotReadsService).to receive(:record_read).and_return(Read.create(link: link))
  end

  context 'user clicks mark as read' do
    it 'changes the style of the link' do
      visit '/'

      within('.link_buttons') {click_on 'Mark as Read'}

      expect(page).to have_content('Mark as Unread')
      expect(page).to have_content('Read? true')

      within('.link_buttons') {click_on 'Mark as Unread'}

      expect(page).to have_content('Mark as Read')
      expect(page).to have_content('Read? false')
    end
  end
end
