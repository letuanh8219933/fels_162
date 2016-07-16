class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find_by params[:user]
    if @user = nil?
      flash[:danger] = t "controller.user_controller.error_norecord"
    else
      relationship = params[:relationship]
      @title = t "follow_user.#{relationship}"
      @users = @user.send(relationship).paginate page: params[:page]
      render "users/show_follow"
    end
  end

  def create
    @user = User.find_by params[:followed_id]
    if @user = nil?
      flash[:danger] = t "controller.user_controller.error_norecord"
      redirect_to current_user
    else
      current_user.follow @user
      respond_to do |format|
        format.html {redirect_to @user}
        format.json{render json: @followers}
        format.js
      end
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.json{render json: @following}
      format.js
    end
  end
end

