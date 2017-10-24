require 'rails_helper'

RSpec.describe 'Complete contractor profile' do
  
  let(:contractor) { create(:contractor) }

  scenario 'visit page' do
    visit edit_contractor_path(contractor)

    expect(page).to have_title('Account | SideWork')
  end

  scenario 'complete profile with valid params' do
    visit edit_contractor_path(contractor)
        
  end
end