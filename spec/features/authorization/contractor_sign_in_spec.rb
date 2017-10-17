require 'rails_helper'

RSpec.describe 'Contractor sign in' do
  scenario 'Visit sign in page' do
    visit signin_path

    expect(page).to have_title('Sign in | SideWork')
  end

  scenario 'With valid inputs and existing account' do
    contractor = create(:contractor, password: 'password123')

    visit signin_path

    fill_in 'session[email]', with: contractor.email
    fill_in 'session[password]', with: contractor.password
    click_on 'Sign in'

    expect(current_path).to eq(contractor_path(contractor))
    within('div.alert') do
      expect(page).to have_content("Welcome, #{contractor.first_name}.")
    end
  end

  context 'with invalid inputs' do
    scenario 'missing password' do
      contractor = create(:contractor, password: 'password123')
    
      visit signin_path
      fill_in 'session[email]', with: contractor.email
    
      click_on 'Sign in'

      expect(current_path).to eq(signin_path)
      within('div.alert') do
        expect(page).to have_content("This Email/Password combination was not found.")
      end
    end

    scenario 'missing email' do
      contractor = create(:contractor, password: 'password123')
      
      visit signin_path
      fill_in 'session[password]', with: contractor.password
      
      click_on 'Sign in'

      expect(current_path).to eq(signin_path)
      within('div.alert') do
        expect(page).to have_content("This Email/Password combination was not found.")
      end
    end

    scenario 'bad email' do
      contractor = create(:contractor, password: 'password123')
      
      visit signin_path
      fill_in 'session[email]', with: 'bad_email#bad.com'
      fill_in 'session[password]', with: contractor.password
      
      click_on 'Sign in'

      expect(current_path).to eq(signin_path)
      within('div.alert') do
        expect(page).to have_content("This Email/Password combination was not found.")
      end
    end

    scenario 'bad_password' do
      contractor = create(:contractor, password: 'password123')
      
      visit signin_path
      fill_in 'session[email]', with: contractor.email
      fill_in 'session[password]', with: 'badpassword'
      
      click_on 'Sign in'

      expect(current_path).to eq(signin_path)
      within('div.alert') do
        expect(page).to have_content("This Email/Password combination was not found.")
      end
    end
  end
end
