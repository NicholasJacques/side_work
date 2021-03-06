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

  scenario 'complete profile with valid inputs' do
    visit edit_restaurant_path(restaurant)

    fill_in 'restaurant[name]', with: "Bertucci's"
    fill_in 'restaurant[manager]', with: "Jane Smith"
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

  context 'bad params' do
    scenario 'missing street address' do
      visit edit_restaurant_path(restaurant)
      
      fill_in 'restaurant[name]', with: "Bertucci's"
      fill_in 'restaurant[manager]', with: "Jane Smith"
      fill_in 'restaurant[user_attributes][address_attributes][street]', with: 'Not a real address'
      fill_in 'restaurant[user_attributes][address_attributes][street2]', with: ' '
      fill_in 'restaurant[user_attributes][address_attributes][city]', with: 'Denver'
      fill_in 'restaurant[user_attributes][address_attributes][state]', with: 'Colorado'
      fill_in 'restaurant[user_attributes][address_attributes][zip_code]', with: '80203'
      click_on 'Update Account'

      restaurant.reload
      expect(page).to have_content("Address can't be confirmed")
      
      expect(restaurant.account_completed?).to eq(false)
    end

    scenario 'change email to empty' do
      visit edit_restaurant_path(restaurant)

      fill_in 'restaurant[user_attributes][email]', with: ' '
      fill_in 'restaurant[name]', with: "Bertucci's"
      fill_in 'restaurant[manager]', with: "Jane Smith"
      fill_in 'restaurant[user_attributes][address_attributes][street]', with: '400 E 8th Avenue'
      fill_in 'restaurant[user_attributes][address_attributes][street2]', with: ' '
      fill_in 'restaurant[user_attributes][address_attributes][city]', with: 'Denver'
      fill_in 'restaurant[user_attributes][address_attributes][state]', with: 'Colorado'
      fill_in 'restaurant[user_attributes][address_attributes][zip_code]', with: '80203'
      click_on 'Update Account'
  
      restaurant.reload
      expect(current_path).to eq(restaurant_path(restaurant))
      expect(page).to have_content("Email can't be blank")
      expect(restaurant.account_completed?).to eq(false)
    end
  end
end
