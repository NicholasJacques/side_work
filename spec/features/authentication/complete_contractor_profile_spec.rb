require 'rails_helper'

RSpec.describe 'Complete contractor profile' do
  
  let(:contractor) { create(:contractor, :activated) }

  scenario 'visit page' do
    visit edit_contractor_path(contractor)
    address = create(:address)

    expect(page).to have_title('Account | SideWork')
  end

  scenario 'complete profile with valid params' do
    visit edit_contractor_path(contractor)

    fill_in 'contractor[address_1]', with: '400 E 8th Avenue'
    fill_in 'contractor[city]',with: 'Denver'
    fill_in 'contractor[state]', with: 'Colorado'
    fill_in 'contractor[zip_code]', with: '80203'
    fill_in 'contractor[work_location]', with: 'Casa Bonita'
    fill_in 'contractor[current_role]', with: 'Line Cook'
    click_on 'Update Account'

    
    # select skills
  end
end