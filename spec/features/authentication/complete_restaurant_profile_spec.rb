require 'rails_helper'

RSpec.describe 'Complete contractor profile' do
  
  let(:restaurant) { create(:restaurant, :activated) }

  before(:each) do
    sign_in(restaurant)
  end

  scenario 'visit page' do
    visit edit_restaurant_path(restaurant)

    expect(page).to have_title('Account | SideWork')
    within('div.alert-warning') do
      expect(page).to have_content('Please complete your account to begin using SideWork')
      expect(page).to have_link("complete", href: edit_restaurant_path(restaurant))
    end 
  end

  context 'complete profile with valid inputs' do
    visit edit_restaurant_path(restaurant)

    fill_in 'restaurant[user_attributes][address_attributes][street]', with: '400 E 8th Avenue'
    fill_in 'restaurant[user_attributes][address_attributes][street2]', with: ' '
    fill_in 'restaurant[user_attributes][address_attributes][city]', with: 'Denver'
    fill_in 'restaurant[user_attributes][address_attributes][state]', with: 'Colorado'
    fill_in 'restaurant[user_attributes][address_attributes][zip_code]', with: '80203'
    click_on 'Update Account'

    restaurant.reload
    expect(current_path).to eq(restaurant_path(restaurant))
    expect(restaurant.account_completed?).to eq(true)
  end
end
