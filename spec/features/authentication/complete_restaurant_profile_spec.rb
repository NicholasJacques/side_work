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
end
