require 'rails_helper'

RSpec.describe 'Restaurant sign in' do
  scenario 'with valid inputs and existing account' do
    restaurant = create(:restaurant)

    visit signin_path

    within('form#signin-form') do
      fill_in 'session[email]', with: restaurant.email
      fill_in 'session[password]', with: restaurant.password
      click_on 'Sign in'
    end

    expect(current_path).to eq(restaurant_path(restaurant))
    expect(page).to have_content("Sign out")
    within('div.alert') do
      expect(page).to have_content("Signed in as #{restaurant.name}.")
    end
  end
end