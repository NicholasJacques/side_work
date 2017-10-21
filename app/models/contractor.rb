class Contractor < ApplicationRecord
  has_one :user, as: :profile, inverse_of: :profile
  accepts_nested_attributes_for :user
  delegate :email, :phone_number, :password, to: :user

  validates :first_name, presence: true,
                         length: { maximum: 50 }
  validates :last_name, presence: true,
                         length: { maximum: 50 }
end
