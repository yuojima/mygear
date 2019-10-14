class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build  # form_with 用
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
    else
      @posts = Post.all
    end
  end
end