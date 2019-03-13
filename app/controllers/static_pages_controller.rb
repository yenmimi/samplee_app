class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.order_time.page(params[:page]).per Settings.paging.per
  end

  def help; end

  def about; end
end
