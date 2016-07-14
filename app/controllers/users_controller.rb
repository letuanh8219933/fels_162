class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :following, :followers]
  before_action :load_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.order(created_at: :desc)
      .paginate page: params[:page],per_page: Settings.per_page
  end

  def show
    unless @user
      flash[:danger] = t "controller.user_controller.error_norecord"
      redirect_to signup_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controller.user_controller.create_user"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controller.user_controller.update_profile"
      redirect_to @user
    else
      render :edit
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render "show_follow"
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "controller.user_controller.error_norecord"
      redirect_to signup_path
    end
  end
end
