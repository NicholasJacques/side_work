require 'rails_helper'

RSpec.describe 'Restaurant sign up' do
  scenario 'visit page' do
    visit restaurant_sign_up_path
    
    expect(page).to have_title('Sign up | SideWork')
  end

  scenario 'with valid inputs' do
    visit restaurant_sign_up_path

    fill_in 'restaurant[name]', with: valid_restaurant_params
    fill_in 'restaurant[email]', with: valid_restaurant_params
    fill_in 'restaurant[password]', with: valid_restaurant_params
    fill_in 'restaurant[password_confirmation]', with: valid_restaurant_params
    
    click_on 'Create Account'

    new
  end

end