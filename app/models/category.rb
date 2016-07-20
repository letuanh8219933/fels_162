class Category < ActiveRecord::Base
  has_many :lesson
  has_many :word
  validates :name, presence: true, uniqueness: {case_sensitive: true}
end
