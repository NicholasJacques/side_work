require 'rails_helper'

RSpec.describe "Visiting the home page as a guest" do
  it "renders the home page with links to login or sign up" do
    visit root_path

    expect(page).to have_title('Home | SideWork')
    
    expect(page).to have_link("Login")
    expect(page).to have_link("Restaurant Looking for Help?")
    expect(page).to have_link("Service Professional Looking for work?")
  end
end
