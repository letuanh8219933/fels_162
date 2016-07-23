class LessonsController < ApplicationController
  before_action :load_lesson, only: [:show, :update]
  before_action :logged_in_user, only: [:create, :update]

  def show
    @words = @lesson.category.words
  end

  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.save
      flash[:success] = t "Success"
      redirect_to @lesson
    else
      flash[:danger] = t "Failed"
      redirect_to categories_url
    end
  end

  private
  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
  end

  def lesson_params
    params.require(:lesson).permit :user_id, :category_id,
      lesson_words_attributes: [:id, :word_id, :word_answer_id, :_destroy]
  end
end
