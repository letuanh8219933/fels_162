class Admin::CategoriesController < ApplicationController
  before_action :load_category, only: [:index, :destroy]

  def index
    @categories = Category.order(:name).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def edit
  end

  def destroy
    if @category.destroy
      flash[:success] = t "admin.delete_category"
    else
      flash[:danger] = t "admin.delete_failed_category"
    end
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end
end
