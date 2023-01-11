class User < ApplicationRecord
  has_many :comments
  has_many :articles, foreign_key: "user_id"
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
