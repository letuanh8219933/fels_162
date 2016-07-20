class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def correct_user
    redirect_to root_url unless @user.is? current_user
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:success] = t "view.login_success"
      redirect_to login_url
    end
  end

  def verify_admin
    if logged_in?
      redirect_to root_path unless current_user.is_admin?
      flash[:danger] = t "message.loggin_success"
    else
      redirect_to root_path
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
