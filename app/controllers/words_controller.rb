class WordsController < ApplicationController
  before_action :logged_in_user, :all_categories_choosed,
    :choose_category, only: :index

  def index
    respond_to do |format|
      if params.has_key?(:word)
        load_lesson_words_id
        all_words_if_params
        format.html
        format.json do
          render json: {
            content: render_to_string({
             partial: "words/word",
             formats: "html",
             layout: false
            })
          }
        end
      else
        all_words
        format.html
        format.json{render json: @words}
      end
    end
  end

  private
  def all_categories_choosed
    ## Load all categories chooesd to learn
      # @categories = Category.eager_load(:users).load_users_involve(current_user)
      #   .order("categories.created_at DESC").all
    ##Load all categories
    @categories = Category.all
  end

  def all_words
    @words = Word.includes(:category)
      .current_user_words(@categories.collect{|category| category.id})
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def all_words_if_params
    @words = Word.includes(:category)
      .current_user_words(eval params[:word][:category_id])
      .send(params[:word][:word_type], @ids)
  end

  def load_lesson_words_id
    @ids = LessonWord.ids.count == 0 ? -1 : LessonWord.all.collect{|lesson| lesson.word_id}
  end

  def choose_category
    @choose_category = [[t("page.front-end.words.index.choose_category"),
      @categories.collect{|category| category.id}]] +
      @categories.collect {|category| [category.name, category.id ]}
  end
end

