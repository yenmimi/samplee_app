class UsersController < ApplicationController
  before_action :find_user, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @user = User.oder_user.page(params[:page]).per Settings.paging.per
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t :success
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @follow_user = current_user.active_relationships.build
    @unfollow_user = current_user.active_relationships.find_by(followed_id: @user.id)
    @microposts = @user.microposts.page(params[:page]).per Settings.paging.per
  end

  def update
    if @user.update user_params
      flash[:success] = t :success_edit
      redirect_to @user
    else
      flash[:danger] = t :danger
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t :user_delete
      redirect_to users_path
    else
      flash[:danger] = t :fail_delete
      redirect_to root_path
    end
  end

  private

  def find_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t :danger_user
    redirect_to action: :new
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def sort_query_params
    params.slice User.all_user
  end
end
