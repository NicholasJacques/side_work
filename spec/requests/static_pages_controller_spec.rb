require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  it 'should GET home' do
    get :home
    assert_response :success
  end
end
