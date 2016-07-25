class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :lesson_words
  has_many :words, through: :lesson_words
  has_many :word_answers, through: :lesson_words

  accepts_nested_attributes_for :lesson_words,
    reject_if: lambda {|attribute| attribute[:word_id].blank?}, allow_destroy: true
  before_create :random_words

  private
  def random_words
    self.words = if category.words.size >= Settings.word_size
      category.words.random.limit Settings.word_size
    else
      category.words.random
    end
  end
end
