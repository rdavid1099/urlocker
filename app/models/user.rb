class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  def is_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end
end
