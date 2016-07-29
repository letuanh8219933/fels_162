class Admin::WordsController < ApplicationController
  before_action :verify_admin
  before_action :load_word, except: :index
  before_action :load_category

  def index
    @categories = Category.order :name
    @words = Word.by_category(params[:category_id]).order(:content)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @word = @category.words.new
    @word.word_answers.new
  end

  def create
    @word = @category.words.new word_params
    @word.category = @category
    if @word.save
      flash[:success] = t "admin.success"
      redirect_to admin_category_url @category
    else
      flash[:danger] = t "admin.Failed"
      render :new
    end
  end

  private
  def load_word
    @word = Word.find_by id: params[:id]
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
  end

  def word_params
    params.require(:word).permit :content,
      word_answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
