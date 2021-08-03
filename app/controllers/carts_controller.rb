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

end
