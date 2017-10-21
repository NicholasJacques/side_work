FactoryGirl.define do
  factory :restaurant do
    name "Antonio's Pizzaria"
    manager 'Nick Jacques'

    after(:build) do |restaurant|
      restaurant.user = build(:user, profile: restaurant)
    end
  end
end
