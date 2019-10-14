class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def new
    if logged_in?
      @post = current_user.posts.build  # form_with 用
      @posts = current_user.posts.order(id: :desc).page(params[:page])
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to root_url
  end

  private

  def post_params
    params.require(:post).permit(:comment, :img)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end