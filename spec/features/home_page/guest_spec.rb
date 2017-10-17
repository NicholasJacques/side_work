require 'rails_helper'

RSpec.describe "Visiting the home page as a guest" do
  it "renders the home page with links to login or sign up" do
    visit root_path

    expect(page).to have_title('Home | SideWork')
  end
end
