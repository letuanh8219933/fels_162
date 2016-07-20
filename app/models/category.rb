class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  validates :name, presence: true, uniqueness: {case_sensitive: true}
end
