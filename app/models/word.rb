class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers
  has_many :lesson_words
  has_many :lessons, through: :lesson_words

  scope :by_category, ->(category_id) do
    where category_id: category_id if category_id.present?
  end
  scope :random, -> {order "RANDOM()"}
  scope :all_word, ->(user_id){}
  scope :learned, ->(user_id) do
    joins(:lessons).distinct.where(lessons: {is_learned: true, user_id: user_id})
  end
  scope :not_learned, ->(user_id) do
    joins(:lessons).distinct.where(lessons: {is_learned: false, user_id: user_id})
  end
  scope :by_category, ->(category_id) do
    where category_id: category_id if category_id.present?
  end

  validates :content, presence: true, uniqueness: true,
    length: {maximum: 255}

  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:content].blank? }

  def answer
    self.word_answers.where(is_correct: true).first
  end
end
