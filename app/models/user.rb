class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  # validates :api_key, presence: true, uniqueness: true
  has_secure_password

end
