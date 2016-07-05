class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answer
  has_many :lesson_word
end
