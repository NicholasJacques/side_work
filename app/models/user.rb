class User < ApplicationRecord
  belongs_to :profile, polymorphic: true, inverse_of: :user

  before_save { email.downcase! }

  validates :email, presence: true,
                    email: true,
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6, maximum: 50 },
                       format: { with: /\d+|\W+/,
                                 message: 'must contain at least one number or special character' }
  # validates :phone_number, presence: true

  def contractor?
    self.profile.class == Contractor
  end
end
