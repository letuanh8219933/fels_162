class User < ActiveRecord::Base
  has_many :activity
  has_many :lesson
  has_many :relationship

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: true}
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, on: :create
  has_secure_password

end
