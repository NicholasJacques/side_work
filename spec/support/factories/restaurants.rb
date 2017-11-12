FactoryGirl.define do
  factory :restaurant do
    name "Antonio's Pizzeria"
    manager 'Nick Jacques'

    trait :activated do
      after(:build) do |restaurant|
        restaurant.user = build(:user, :activated, profile: restaurant)
      end
    end

    after(:build) do |restaurant|
      if restaurant.user.nil?
        restaurant.user = build(:user, profile: restaurant)
      end
    end
  end
end
