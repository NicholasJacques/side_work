require 'rails_helper'

RSpec.describe 'sign out contractor' do
  it 'signs out contractor and redirects to home page' do
    contractor = create(:contractor)
    sign_in_contractor(contractor)

    visit contractor_path(contractor)

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