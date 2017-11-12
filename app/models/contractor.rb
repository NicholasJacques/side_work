class Contractor < ApplicationRecord
  has_one :user, as: :profile, inverse_of: :profile
  accepts_nested_attributes_for :user
  has_one :address, through: :user
  delegate :email, :phone_number, :password, :send_activation_email, :account_completed?, to: :user

  validates :first_name, presence: true,
                         length: { maximum: 50 }
  validates :last_name, presence: true,
                         length: { maximum: 50 }


  def complete_account
    user.update_attribute(:account_completed, true)
  end
end
