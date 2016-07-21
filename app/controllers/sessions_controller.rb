class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      @current_user = user
      flash[:success] = t "controller.sessions_controller.success"
      if user.is_admin?
        redirect_to admin_root_url
      else
        redirect_to root_url
      end
    else
      flash[:danger] = t "controller.sessions_controller.error_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
