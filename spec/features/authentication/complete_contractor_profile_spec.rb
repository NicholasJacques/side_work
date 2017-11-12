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
    fill_in 'contractor[user_attributes][address_attributes][city]', with: 'Denver'
    fill_in 'contractor[user_attributes][address_attributes][state]', with: 'Colorado'
    fill_in 'contractor[user_attributes][address_attributes][zip_code]', with: '80203'
    click_on 'Update Account'

    contractor.reload
    expect(current_path).to eq(contractor_path(contractor))
    expect(contractor.account_completed?).to eq(true)
  end

  context 'bad params' do
    scenario 'missing street address' do
      visit edit_contractor_path(contractor)

      fill_in 'contractor[user_attributes][address_attributes][street2]', with: ' '
      fill_in 'contractor[user_attributes][address_attributes][city]', with: 'Denver'
      fill_in 'contractor[user_attributes][address_attributes][city]', with: 'Colorado'
      fill_in 'contractor[user_attributes][address_attributes][zip_code]', with: '80203'
      click_on 'Update Account'

      contractor.reload
      expect(current_path).to eq(contractor_path(contractor))
      expect(page).to have_content("Street address can't be blank")
      expect(contractor.account_completed?).to eq(false)
    end

    scenario 'invalid address' do
      visit edit_contractor_path(contractor)
      
      fill_in 'contractor[user_attributes][address_attributes][street]', with: 'not a real address'
      fill_in 'contractor[user_attributes][address_attributes][street2]', with: ' '
      fill_in 'contractor[user_attributes][address_attributes][city]', with: 'Denver'
      fill_in 'contractor[user_attributes][address_attributes][city]', with: 'Colorado'
      fill_in 'contractor[user_attributes][address_attributes][zip_code]', with: '80203'
      click_on 'Update Account'

      contractor.reload
      expect(current_path).to eq(contractor_path(contractor))
      expect(page).to have_content("Address can't be confirmed")
      expect(contractor.account_completed?).to eq(false)
    end

    scenario 'change email to empty' do
      visit edit_contractor_path(contractor)
  
      fill_in 'contractor[user_attributes][email]', with: ' '
      fill_in 'contractor[user_attributes][address_attributes][street]', with: '400 E 8th Avenue'
      fill_in 'contractor[user_attributes][address_attributes][street2]', with: ' '
      fill_in 'contractor[user_attributes][address_attributes][city]', with: 'Denver'
      fill_in 'contractor[user_attributes][address_attributes][state]', with: 'Colorado'
      fill_in 'contractor[user_attributes][address_attributes][zip_code]', with: '80203'
      click_on 'Update Account'
  
      contractor.reload
      expect(current_path).to eq(contractor_path(contractor))
      expect(page).to have_content("Email can't be blank")
      expect(contractor.account_completed?).to eq(false)
    end
  end
end