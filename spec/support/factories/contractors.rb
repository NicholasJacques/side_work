FactoryGirl.define do
  factory :contractor do
    first_name 'Nick'
    last_name 'Jacques'
    after(:build) do |contractor|
      contractor.user = build(:user, profile: contractor)
    end
  end
end
