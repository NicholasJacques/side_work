require 'rails_helper'

RSpec.describe Contractor, type: :model do

  it 'has a valid factory' do
    expect(build(:contractor)).to be_valid
  end

end
