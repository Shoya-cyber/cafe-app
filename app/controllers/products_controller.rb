class ProductsController < ApplicationController
  before_action :move_to_root, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:edit, :update, :destroy]

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
  end

  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :info, :price, :image)
  end

  def move_to_root
    redirect_to root_path unless user_signed_in? && current_user.admin == true
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
