class Admin::CategoriesController < ApplicationController
  layout "admin"
  before_action :load_category, except: [:new, :create]
  before_action :verify_admin
  def index
    @categories = Category.order(:name).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "admin.create_category"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "admin.update_category"
      redirect_to admin_categories_url
    else
      render :edit
    end
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
