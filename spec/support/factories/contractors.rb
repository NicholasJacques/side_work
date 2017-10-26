FactoryGirl.define do
  factory :contractor do
    first_name 'Nick'
    last_name 'Jacques'

    trait :activated do
      after(:build) do |contractor|
        contractor.user = build(:user, :activated, profile: contractor)
      end
    end

    after(:build) do |contractor|
      if contractor.user.nil?
        contractor.user = build(:user, profile: contractor)
      end
    end
  end
end
