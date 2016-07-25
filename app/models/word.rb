class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers
  has_many :lesson_words
  scope :by_category, ->(category_id) do
    where category_id: category_id if category_id.present?
  end
  scope :random, -> {order "RANDOM()"}

  validates :content, presence: true, uniqueness: true,
    length: {maximum: 255}

  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:content].blank? }
end
