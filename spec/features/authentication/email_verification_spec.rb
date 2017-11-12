require 'rails_helper'

RSpec.describe 'email verification' do
  scenario 'valid verification url' do
    user = create(:user)
    sign_in(user.profile)

    visit polymorphic_path(user.profile)

    within('div.alert') do
      expect(page).to have_content('Please check your email to verify your account')
    end

    visit edit_account_activation_path(user.activation_token, email: user.email)
    user.reload
    expect(current_path).to eq(polymorphic_path(user.profile))
    within('div.alert-success') do
      expect(page).to have_content('Thank you for verifying your email')
    end

    visit polymorphic_path(user.profile)
    expect(user.activated?).to be true
    expect(page).to_not have_content('Please check your email to verify your account')
  end

end
