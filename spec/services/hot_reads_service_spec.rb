require 'rails_helper'

describe 'HotReadsService' do
  let(:service) {HotReadsService}

  context '#record_read' do
    it 'records read of link' do
      service.record_read(create_link)

      expect(Read.count).to eq(1)
    end
  end
end
