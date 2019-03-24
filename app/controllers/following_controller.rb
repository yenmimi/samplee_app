class FollowingController < ApplicationController
  def show
    @title = t :following
    @user = User.find_by id: params[:id]
    @users = @user.following.page(params[:page]).per Settings.twomuoi
    render "users/show_follow"
  end
end
