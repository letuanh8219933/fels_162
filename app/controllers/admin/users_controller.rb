class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :verify_admin, :load_user

  def index
    @users = User.order(:name).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.delete_user"
    else
      flash[:danger] = t "admin.delete_failed"
    end
    redirect_to admin_users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
