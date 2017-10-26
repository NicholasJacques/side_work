require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'has a valid factor' do
    expect(build(:address)).to be_valid
  end

  let(:address) { build(:address) }

  describe 'associations' do
    it 'belongs to a user' do
      expect(address.user).to be_a(User)
    end
  end
end
