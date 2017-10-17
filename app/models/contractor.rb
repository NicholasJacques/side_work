class Contractor < ApplicationRecord
  before_save { email.downcase! }

  validates :first_name, presence: true,
                         length: { maximum: 50 }
  validates :last_name, presence: true,
                         length: { maximum: 50 }
  validates :email, presence: true,
                    email: true,
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password, length: { minimum: 6, maximum: 50 },
                       format: { with: /\d+|\W+/,
                         message: 'must contain at least one number or special character' }

end
