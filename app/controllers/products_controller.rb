class ProductsController < ApplicationController
  before_action :move_to_root, only: [:new, :create]

  def index
    @products = Product.all.order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :info, :price, :image)
  end

  def move_to_root
    redirect_to root_path unless user_signed_in? && current_user.admin == true
  end

end
