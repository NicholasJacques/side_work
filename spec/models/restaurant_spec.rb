require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  let(:restaurant) { build(:restaurant) }

  describe 'attributes' do
    describe 'name' do
      it 'must exist' do
        restaurant.name = nil
        expect(restaurant).to_not be_valid
      end

      it 'cannot be longer than 64' do
        restaurant.name = 'A' * 65
        expect(restaurant).to_not be_valid
        restaurant.name = 'A' * 64
        expect(restaurant).to be_valid
      end

      it 'must contain at least one character' do
        restaurant.name = 'A'
        expect(restaurant).to be_valid
        restaurant.name = ' '
        expect(restaurant).to_not be_valid
      end
    end

    describe 'delegation' do
      it 'delegates email to user' do
        expect(restaurant.email).to eq(restaurant.user.email)
      end

      it 'delegates phone_number to user' do
        expect(restaurant.phone_number).to eq(restaurant.user.phone_number)
      end

      it 'delegate password to user' do
        expect(restaurant.password).to eq(restaurant.user.password)
      end
    end
  end
end
