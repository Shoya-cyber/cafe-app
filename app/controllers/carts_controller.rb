class CartsController < ApplicationController
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
  end

  def add_cart
    if session[:cart].blank?
      session[:cart] = [{ product_id: params["product_id"], quantity: params["quantity"].to_i }]
    else
      match = session[:cart].select {|cart| cart["product_id"] == params["product_id"] }
      if match.present?
        match[0]["quantity"] += params["quantity"].to_i
      else
        session[:cart].push({ product_id: params["product_id"], quantity: params["quantity"].to_i })
      end
    end
    redirect_to products_path

    
  end


  def change_quantity
    array_index = session[:cart].each_index.select {|i| session[:cart][i]["product_id"] == params["product_id"] }
    session[:cart][array_index[0]]["quantity"] = params["quantity"]
    redirect_to carts_show_path
  end

  def destroy_carts_item
    array_index = session[:cart].each_index.select {|i| session[:cart][i]["product_id"] == params["product_id"] }
    session[:cart].delete_at(array_index[0])
    redirect_to carts_show_path
  end

end
