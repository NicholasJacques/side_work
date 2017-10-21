require 'rails_helper'

RSpec.describe 'sign out restaurant' do
  it 'signs out restaurant and redirects to home page' do
    restaurant = create(:contractor)
    sign_in(restaurant)

    visit restaurant_path(restaurant)

    within('header') do
      click_on 'Sign out'
    end

    expect(current_path).to eq(root_path)
    within('header') do
      expect(page).to_not have_content('Sign out')
      expect(page).to have_content('Sign in')
    end
  end
end