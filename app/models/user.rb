# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  coins           :string(255)
#

class User < ActiveRecord::Base
  has_many :workers, dependent: :destroy
  attr_accessible :coins, :email, :name, :password, :password_confirmation
  has_secure_password


  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :coins, presence: true, format: { with: VALID_COINS_REGEX }

  private
    def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
    end


end             
