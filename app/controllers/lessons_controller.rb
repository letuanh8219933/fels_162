class LessonsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update]
  before_action :load_category, only: [:show, :create]
  before_action :load_lesson, only: [:show, :update]

  def show
  end

  def create
    @lesson = current_user.lessons.build category_id: @category.id
    @lesson.create_word
    if @lesson.save
      flash[:success] = t "category.lesson.create_success"
      redirect_to @lesson
    else
      flash[:danger] = t "category.lesson.create_fail"
      redirect_to categories_path
    end
  end

  def update
    if @lesson.update_attributes lesson_params
      redirect_to @lesson
      flash[:success] = t "category.lesson.save_success"
    else
      flash[:danger] = t "category.lesson.save_fail"
      redirect_to :back
    end
  end

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
  end

  def lesson_params
    params.require(:lesson).permit :user_id, :category_id,
      lesson_words_attributes: [:id, :word_id, :word_answer_id, :_destroy]
  end
end
