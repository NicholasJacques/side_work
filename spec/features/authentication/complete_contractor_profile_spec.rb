require 'rails_helper'

RSpec.describe 'Complete contractor profile' do

  let(:contractor) { create(:contractor, :activated) }

  before(:each) do
    sign_in(contractor)
  end

  scenario 'visit page' do
    visit edit_contractor_path(contractor)

    expect(page).to have_title('Account | SideWork')
    within('div.alert-warning') do
      expect(page).to have_content('Please complete your account to begin using SideWork')
      expect(page).to have_link("complete", href: edit_contractor_path(contractor))
    end
  end

  scenario 'complete profile with valid params' do
    visit edit_contractor_path(contractor)

    fill_in 'contractor[user_attributes][address_attributes][street]', with: '400 E 8th Avenue'
    fill_in 'contractor[user_attributes][address_attributes][street2]', with: ' '
    fill_in 'contractor[user_attributes][address_attributes][city]', with: 'Colorado'
    fill_in 'contractor[user_attributes][address_attributes][zip_code]', with: '80203'
    # fill_in 'contractor[work_location]', with: 'Casa Bonita'
    # fill_in 'contractor[current_role]', with: 'Line Cook'
    click_on 'Update Account'

    expect(current_path).to eq(contractor_path(contractor))
  end
end