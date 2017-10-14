class Contractor < ApplicationRecord
  validates :first_name, presence: true,
                         length: { maximum: 50, minimum: 2 }
  validates :last_name, presence: true,
                         length: { maximum: 50, minimum: 2 }
  validates :email, presence: true,
                    length: { maximum: 255 }     

  has_secure_password
end
