class CartsController < ApplicationController
  
  def add_cart
    if session[:cart].blank?
      session[:cart] = [{ product_id: params["product_id"], quantity: params["quantity"].to_i}]
    end

    match = session[:cart].select {|cart| cart["product_id"] == params["product_id"]}

    if match.present?
      match[0]["quantity"] += params["quantity"].to_i
    else
      session[:cart].push({ product_id: params["product_id"], quantity: params["quamtity"].to_i })
    end
  end

  def show
    return if session[:cart].blank?

    @cart = []
    session[:cart].each do |cart|
      product = Product.find_by(id: cart["product_id"])
      sub_total = product.price * cart["quantity"].to_i
      next unless product

      @cart.push({ product_id: product.id,
                   name: product.product_name,
                   price: product.price,
                   quantity: cart["quantity"].to_i,
                   sub_total: sub_total })
      end
      @cart_total_price = cart_total_price(@cart)
  end

end
