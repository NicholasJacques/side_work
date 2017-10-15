require 'rails_helper'

RSpec.describe ContractorsController, type: :request do
  describe 'GET #new' do
    it 'returns http success' do
      get contractor_sign_up_path

      expect(response).to have_http_status(:success)
      expect(assigns(:contractor)).to be_a_new(Contractor)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    scenario 'with valid params' do
      expect { post contractors_path, params: { contractor: valid_contractor_params } }.
        to change { Contractor.count }.by(1)
      new_contractor = Contractor.last

      expect(response).to have_http_status(:found)
      expect(assigns(:contractor)).to eq(new_contractor)
      expect(response).to redirect_to(contractor_path(new_contractor))

      expect(new_contractor.first_name).to eq(valid_contractor_params[:first_name])
      expect(new_contractor.last_name).to eq(valid_contractor_params[:last_name])
      expect(new_contractor.email).to eq(valid_contractor_params[:email])
    end

    scenario 'with invalid params' do
      expect { post contractors_path, params: { contractor: invalid_contractor_params } }
        .to_not(change { Contractor.count })

      expect(response).to have_http_status(:ok)
      expect(response).to render_template('new')
      expect(assigns(:contractor)).to be_a_new(Contractor)
    end
  end
end
