require 'rails_helper'

RSpec.describe 'guest header' do
  before(:each) do
    visit root_path
  end

  it 'has a link to the home page' do
    within('header') do
      expect(page).to have_link('SideWork', href: root_path)
    end
  end

  it 'has a link to sign in' do
    within('header') do
      expect(page).to have_link('Sign in', href: signin_path)
    end
  end

  it 'has a link to sign up as a contractor' do
    within('header') do
      expect(page).to have_link('Start Picking up Sidework', href: contractor_sign_up_path)
    end
  end

  it 'has a link to sign up as a restaurant' do
    within('header') do
      expect(page).to have_link('Hire', href: restaurant_sign_up_path)
    end
  end

  it 'does not have a link to log out' do
    expect(page).to_not have_link('Sign out')
  end
end