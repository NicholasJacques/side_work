class User < ApplicationRecord
  attr_accessor :activation_token

  before_save :downcase_email
  before_create :create_activation_digest

  belongs_to :profile, polymorphic: true, inverse_of: :user

  has_one :address
  accepts_nested_attributes_for :address
  after_create :create_empty_address

  validates :email, presence: true,
                    email: true,
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6, maximum: 50 },
                       format: { with: /\d+|\W+/,
                                 message: 'must contain at least one number or special character' },
                       allow_nil: true

  # validates :phone_number, presence: true

  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def contractor?
    self.profile.class == Contractor
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    update_columns(activated: true, activated_at: Time.now)
  end

  def authenticated?(activation_token)
    return false if activation_digest.nil?
    BCrypt::Password.new(activation_digest).is_password?(activation_token)
  end

  private

    def create_empty_address
      self.build_address
      address.save(validate: false)
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    def downcase_email
      self.email = email.downcase
    end
end
