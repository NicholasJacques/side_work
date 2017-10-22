require 'rails_helper'

RSpec.describe 'Restaurant sign up' do
  after(:each) do 
    ActionMailer::Base.deliveries.clear
  end

  scenario 'visit page' do
    visit restaurant_sign_up_path

    expect(page).to have_title('Sign up | SideWork')
  end

  scenario 'with valid inputs' do
    visit restaurant_sign_up_path

    fill_in 'restaurant[name]', with: valid_restaurant_params[:name]
    fill_in 'restaurant[user_attributes][email]', with: valid_restaurant_params[:user_attributes][:email]
    fill_in 'restaurant[user_attributes][password]', with: valid_restaurant_params[:user_attributes][:password]
    fill_in 'restaurant[user_attributes][password_confirmation]', with: valid_restaurant_params[:user_attributes][:password_confirmation]
    click_on 'Create Account'

    expect(ActionMailer::Base.deliveries.size).to eq(1)    
    new_restaurant = Restaurant.last
    expect(current_path).to eq(restaurant_path(new_restaurant))
    expect(page).to have_content('Please check your email to continue setting up your account')
  end

  context 'with invalid inputs' do
    scenario 'with an invalid email' do
      visit restaurant_sign_up_path
        fill_in 'restaurant[name]', with: valid_restaurant_params[:name]
        fill_in 'restaurant[user_attributes][email]', with: 'bad#email.com'
        fill_in 'restaurant[user_attributes][password]', with: valid_restaurant_params[:user_attributes][:password]
        fill_in 'restaurant[user_attributes][password_confirmation]', with: valid_restaurant_params[:user_attributes][:password_confirmation]
        click_on 'Create Account'

      expect(current_path).to eq(restaurants_path)
      expect(ActionMailer::Base.deliveries.size).to eq(0)      
      within('div#error-explanation') do
        expect(page).to have_css('div.alert-danger', text: 'The form contains 1 error.')
        expect(page).to have_css('li', text: 'User email is invalid')
      end
      expect(User.count).to eq(0)
      expect(Restaurant.count).to eq(0)
    end
  end
end