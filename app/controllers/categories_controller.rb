class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :eager_loading_lessons, only: :show

  def index
    @categories = Category.order(created_at: :desc)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @lessons = @category.lessons
    @words = @category.words
    @lesson = Lesson.new
  end

  private
  def eager_loading_lessons
    @category = Category.includes(:lessons, :words).find_by id: params[:id]
  end
end
