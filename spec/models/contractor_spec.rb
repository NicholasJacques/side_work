require 'rails_helper'

RSpec.describe Contractor, type: :model do
  it 'has a valid factory' do
    expect(build(:contractor)).to be_valid
  end

  let(:contractor) { build(:contractor) }
  
  describe 'attributes' do
    describe 'first_name' do
      it 'must exist' do
        contractor.first_name = nil
        expect(contractor).to_not be_valid
      end

      it 'cannot be longer than 50 chars' do
        contractor.first_name = 'a' * 51
        expect(contractor).to_not be_valid
      end
    end

    describe 'last_name' do
      it 'must exist' do
        contractor.last_name = nil
        expect(contractor).to_not be_valid 
      end

      it 'cannot be longer than 50 chars' do
        contractor.last_name = 'a' * 51
        expect(contractor).to_not be_valid
      end
    end

    describe 'delegation' do
      it 'delegates email to user' do
        expect(contractor.email).to eq(contractor.user.email)
      end

      it 'delegates phone_number to user' do
        expect(contractor.phone_number).to eq(contractor.user.phone_number)
      end

      it 'delegates password to user' do
        expect(contractor.password).to eq(contractor.user.password)
      end
    end
  end
end
