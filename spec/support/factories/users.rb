FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@test.com"
  end

  factory :user do
    email
    password 'password123'
    phone_number '111-111-1111'
    after(:build) do |user|
      if user.profile.nil?
        user.profile = build(:contractor)
      end
    end
  end
end
