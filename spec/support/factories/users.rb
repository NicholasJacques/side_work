FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@test.com"
  end

  factory :user do
    email
    password 'password123'
    phone_number '111-111-1111'

    trait :activated do
      activated true
      activated_at Time.now
    end

    trait :contractor do
      after(:build) do |user|
        user.profile = build(:contractor)
      end
    end

    trait :restaurant do
      after(:build) do |user|
        user.profile = build(:restaurant)
      end
    end

    after(:build) do |user|
      if user.profile.nil?
        [0, 1].sample == 0 ? user.profile = build(:contractor) :
                             user.profile = build(:restaurant)
      end
    end
  end
end
