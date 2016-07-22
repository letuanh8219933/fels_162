class Category < ActiveRecord::Base
  has_many :lessons
  has_many :users, through: :lessons
  has_many :words, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: true}
  validates :description, presence: true
  scope  :load_users_involve, ->(current_user){where "users.id = ?", current_user.id}
end
