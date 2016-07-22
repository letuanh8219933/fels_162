class LessonWord < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer

  scope :is_corrects, -> do
    joins(:word_answer).where word_answers: {is_correct: true}
  end
  scope :is_fails, -> do
    joins(:word_answer).where word_answers: {is_correct: false}
  end

  scope :filter_corrects, -> do
    joins(:word_answer).having word_answers: {is_correct: true}
  end

  scope :filter_fails, -> do
    joins(:word_answer).having word_answers: {is_correct: false}
  end
  scope :is_fails, -> do
    joins(:word_answer).where word_answers:{is_correct: false}
  end
end
