require 'rails_helper'

RSpec.describe AccountActivationsController, type: :request do
  # let(:user) { create(:user) }

  describe 'get #edit' do
    context 'with valid params' do
      it 'activates the user' do
        user = create(:user)

        get edit_account_activation_path(user.activation_token, email: user.email)
        user.reload

        expect(user.activated?).to be true
        expect(assigns(:current_user)).to eq(user)
        expect(response).to redirect_to(polymorphic_path(user.profile))
      end
    end

    context 'with invalid params' do
      it 'cannot find email' do
        user = create(:user)

        get edit_account_activation_path(user.activation_token, email: 'bad@email.com')
        user.reload

        expect(user.activated?).to be false
        expect(assigns(:current_user)).to be nil
        expect(response).to redirect_to(root_path)
      end

      it 'receives a bad token' do
        user = create(:user)
        
        get edit_account_activation_path('bad_token', email: user.email)
        user.reload

        expect(user.activated?).to be false
        expect(assigns(:current_user)).to be nil
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
