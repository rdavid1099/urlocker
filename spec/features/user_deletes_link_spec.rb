require 'rails_helper'

describe 'delete links', :js => :true do
  let(:user) {create_user}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    create_link(user)
  end

  context 'user clicks delete' do
    it 'removes link from the list and database' do
      visit '/'

      within('.link_buttons') {click_link 'Delete'}

      expect(page).to have_content('Link Successfully Deleted')
      expect(Link.count).to eq(0)
    end
  end
end
