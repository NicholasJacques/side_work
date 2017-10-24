class Restaurant < ApplicationRecord
  has_one :user, as: :profile, inverse_of: :profile
  accepts_nested_attributes_for :user
  delegate :email, :phone_number, :password, :send_activation_email, to: :user
  validates :name, presence: true,
                   length: { minimum: 1, maximum: 64 }
end
