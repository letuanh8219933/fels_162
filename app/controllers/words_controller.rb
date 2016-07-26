class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.order(:name)
    word_type = params[:word_type] || Settings.all_word
    @words = Word.send(word_type, current_user)
      .by_category(params[:by_category])
      .order(:content)
      .paginate page: params[:page], per_page: Settings.per_page
  end
end
