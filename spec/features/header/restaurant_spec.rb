require 'rails_helper'

RSpec.describe 'header viewed by an authenticated restaurant' do
  before(:each) do
    sign_in_contractor(create(:contractor))
    visit root_path
  end

  it 'has a link to the home page' do 
    within('header') do
      expect(page).to have_link('SideWork', href: root_path)
    end
  end

  it 'does not have a link to sign in' do
    within('header') do
      expect(page).to_not have_link('Sign in', href: signin_path)      
    end
  end

  it 'does not have a link to sign up as a contractor' do
    within('header') do
      expect(page).to_not have_link('Start Picking up Sidework', href: '#')      
    end
  end

  it 'does not have a link to sign up as a restaurant' do
    within('header') do
      expect(page).to_not have_link('Hire', href: '#')
    end
  end

  it 'has a link to log out' do
    expect(page).to have_link('Sign out', href: signout_path)
  end

end