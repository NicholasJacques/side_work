FactoryGirl.define do
  factory :address do
    street '100 Detroit Street'
    street2 '#703'
    zip_code '80206'
    association :user, factory: :user, activated: true, activated_at: Time.now
  end
end
