class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :move_to_root, only: [:new]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_category_id, :title, :text, :image).merge(user_id: current_user.id)
  end

  def move_to_root
    redirect_to root_path unless user_signed_in? && current_user.admin == true
  end
end
