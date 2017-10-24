require 'rails_helper'

RSpec.describe 'Complete contractor profile' do
  
  let(:contractor) { create(:contractor) }

  scenario 'visit page' do
    visit edit_contractor_path(contractor)

    
  end

  scenario 'with valid inputs' do
    visit edit_contractor_path
    
  end
end