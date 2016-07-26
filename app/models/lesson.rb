class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :lesson_words
  has_many :words, through: :lesson_words
  has_many :word_answers, through: :lesson_words

  accepts_nested_attributes_for :lesson_words,
    reject_if: lambda {|attribute| attribute[:word_id].blank?}, allow_destroy: true
  before_create :random_words
  before_update :change_is_completed

  def score
    word_answers = self.lesson_words.joins(:word_answer)
    correct = word_answers.select{|item| item.is_correct?}.size
    total = word_answers.size
    "#{correct} / #{total}"
  end

  private
  def random_words
    self.words = if category.words.size >= Settings.word_size
      category.words.random.limit Settings.word_size
    else
      category.words.random
    end
  end

  def change_is_completed
    self.update_attributes is_learned: true unless self.is_learned?
  end
end
