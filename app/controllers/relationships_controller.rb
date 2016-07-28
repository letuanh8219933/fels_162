class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find_by id: params[:user]
    if @user.nil?
      flash[:danger] = t "controller.user_controller.error_norecord"
    else
      relationship = params[:relationship]
      @title = t "relationship.#{relationship}"
      @users = @user.send(relationship).paginate page: params[:page]
      render "users/show_follow"
    end
  end

  def create
    @user = User.find_by params[:followed_id]
    if @user.nil?
      flash[:danger] = t "controller.user_controller.error_norecord"
    else
      current_user.follow @user
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    if @user.nil?
      flash[:danger] = t "controller.user_controller.error_norecord"
    else
      current_user.unfollow @user
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    end
  end
end

