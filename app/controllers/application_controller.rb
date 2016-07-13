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
      flash[:danger] = t "controller.user_controller.danger"
      redirect_to login_url
    end
  end
end
