class Lesson < ActiveRecord::Base
  include CreateActivity

  belongs_to :category
  belongs_to :user
  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words
  has_many :word_answers, through: :lesson_words
  has_many :activities, dependent: :destroy

  after_update :create_activity_learned

  accepts_nested_attributes_for :lesson_words,
    reject_if: lambda {|a| a[:word_id].blank?}, allow_destroy: true

  validate :word_min, on: :create
  before_update :change_is_completed
  # before_update :create_activity_learning
  after_update :create_activity_learned

  def create_word
    byebug
    self.words = if category.words.size >= Settings.word_size
      category.words.order("RANDOM()").limit Settings.number_words_per_lesson
    else
      category.words.order("RANDOM()")
    end
  end

  private
  def change_is_completed
    self.update_attributes is_completed: true unless self.is_completed?
  end

  def word_min
    errors.add :create,
      I18n.t("category.lesson.create_fail") if self.words.size < Settings.number_words_min
  end

  def create_activity_learned
    create_activity self.id, Settings.activity_type.learned, self.user.id
  end

  ##Create learning activity
    # def create_activity_learning
    #   create_activity self.id, Settings.activity_type.learning, self.user.id
    # end
end
