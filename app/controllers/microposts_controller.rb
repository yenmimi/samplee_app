class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def new; end

  def create
    @micropost = current_user.microposts.build micropost_params

    if @micropost.save
      flash[:success] = t :success_save_micro
      redirect_to root_url
    else
      @feed_items = current_user.feed.page params[:page]
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t :delete_micropost
      redirect_to request.referrer || root_url
    else
      flash[:danger] = t :fail_delete
      redirect_to root_path
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost
  end
end
