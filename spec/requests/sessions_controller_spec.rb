require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe 'GET #new' do
    it 'returns http success' do
      get signin_path

      expect(response).to have_http_status(:success)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    scenario 'with valid_params' do
      contractor = create(:contractor)

      post signin_path, params: { session: { email:    contractor.email,
                                             password: contractor.password } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(contractor_path(contractor))
    end

    context 'invalid params' do
      scenario 'bad password' do
        contractor = create(:contractor)

        post signin_path, params: { session: { email:    contractor.email,
                                               password: 'bad_password' } }

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end
end
