class PostsController < ApplicationController
  before_action :move_to_root, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

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

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
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
