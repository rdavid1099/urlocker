require 'rails_helper'

describe 'reads link', :js => :true do
  let(:user) {create_user}

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = create_link(user)
    allow(HotReadsService).to receive(:record_read).and_return(Read.create(link: link))
  end

  context 'user clicks mark as read' do
    it 'marks link as read' do
      visit '/'

      within('.link_buttons') {click_on 'Mark as Read'}
      expect(Read.count).to eq(1)
    end
  end
end
