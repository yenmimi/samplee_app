class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
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
    @user = User.find_by id: params[:id]
    
    return if @user
    redirect_to action: :new
    flash[:danger] = t :fail_find
  end

  def edit; end

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
    if User.find_by(id: params[:id]).destroy
      flash[:success] = t :user_delete
      redirect_to users_path
    else
      flash[:danger] = t :fail_delete
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t :need_login
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user.current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def sort_query_params
    params.slice User.all_user
  end
end
