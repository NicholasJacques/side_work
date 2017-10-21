require 'rails_helper'

RSpec.describe RestaurantsController, type: :request do
  describe "GET #new" do
    it "returns http success" do
      get restaurant_sign_up_path

      expect(response).to have_http_status(:success)
      expect(assigns(:restaurant)).to be_a_new(Restaurant)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    scenario 'with valid params' do
      expect { post restaurants_path, params: { restaurant: valid_restaurant_params } }
        .to change { Restaurant.count }.by(1)

      new_restaurant = Restaurant.last
      expect(User.count).to eq(1)
      expect(response).to have_http_status(:found)
      expect(assigns(:restaurant)).to eq(new_restaurant)
    end

    scenario 'with invalid params' do
      expect { post restaurants_path, params: { restaurant: invalid_restaurant_params } }
        .to_not change { Restaurant.count }

      expect(Restaurant.count).to eq(0)
      expect(User.count).to eq(0)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('new')
      expect(assigns(:restaurant)).to be_a_new(Restaurant)
    end
  end
end
