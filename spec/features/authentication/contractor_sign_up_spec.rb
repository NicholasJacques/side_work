require 'rails_helper'

RSpec.describe 'Contractor Sign Up' do
  scenario 'visit page' do
    visit contractor_sign_up_path

    expect(page).to have_title('Sign up | SideWork')
  end

  scenario 'sign up with valid inputs' do
    visit contractor_sign_up_path

    fill_in 'contractor[first_name]', with: valid_contractor_params[:first_name]
    fill_in 'contractor[last_name]',  with: valid_contractor_params[:last_name]
    fill_in 'contractor[email]',      with: valid_contractor_params[:email]
    fill_in 'contractor[password]',   with: valid_contractor_params[:password]
    fill_in 'contractor[password_confirmation]', with: valid_contractor_params[:password]
    click_on 'Create Account'

    new_contractor = Contractor.last
    expect(current_path).to eq(contractor_path(new_contractor))
    expect(page).to have_content('Welcome to SideWork')
  end

  context 'with invalid inputs' do
    scenario 'missing email' do
      visit contractor_sign_up_path
      
      fill_in 'contractor[first_name]', with: valid_contractor_params[:first_name]
      fill_in 'contractor[last_name]',  with: valid_contractor_params[:last_name]
      fill_in 'contractor[email]',      with: ''
      fill_in 'contractor[password]',   with: valid_contractor_params[:password]
      fill_in 'contractor[password_confirmation]', with: valid_contractor_params[:password]
      click_on 'Create Account'

      expect(current_path).to eq(contractors_path)
      within('div#error-explanation') do
        expect(page).to have_css('div.alert-danger', text: 'The form contains 1 error.')
        expect(page).to have_css('li', text: "Email can't be blank")
      end
    end
  end
end
