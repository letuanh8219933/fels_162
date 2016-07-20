class Admin::WordsController < ApplicationController
  before_action :load_word, except: [:index]
  before_action :load_category

  def index
    @categories = Category.order :name
    @words = Word.by_category(params[:category_id]).order(:content)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  private
  def load_word
    @word = Word.find_by id: params[:id]
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end
end
