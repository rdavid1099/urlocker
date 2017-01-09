require 'rails_helper'

describe 'reads link', :js => :true do
  let(:user) {create_user}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    create_link(user)
  end

  context 'user clicks mark as read' do
    it 'removes link from the list and database' do
      visit '/'

      within('.link_buttons') {click_on 'Mark as Read'}
      expect(Read.count).to eq(1)
    end
  end
end
