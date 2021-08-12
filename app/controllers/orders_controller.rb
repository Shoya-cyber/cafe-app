class OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = Address.find_by(user_id: current_user.id)

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    customer= Payjp::Customer.retrieve(card.customer_id)
    @card = customer.cards.first

    @cart = []
    session[:cart].each do |cart|
      product = Product.find_by(id: cart["product_id"])
      sub_total = product.price * cart["quantity"].to_i
      next unless product

      @cart.push({ product_id: product.id,
                   image: product.image,
                   name: product.product_name,
                   price: product.price,
                   quantity: cart["quantity"].to_i,
                   sub_total: sub_total })
    end
  end
    
  def create
    session[:cart].each do |cart|
      total_quantity = 0
      total_price = 0

      total_quantity += cart["quantity"].to_i
      total_price += cart["price"].to_i 
        return
        
        @order = Order.new(
          user_id: current_user.id,
          address_id: current_user.address.id,
          card_id: current_user.card.id,
          total_quantity: total_quantity,
          total_price: total_price
        )
        
        @order_detail = OrderDetail.new(
          order_id: current_order.id,
          product_id: cart["product_id"],
          quantity: cart["quantity"]
        )
    end
    if @order.valid? && @order_detail.valid?
      @order.save && @order_detail.save
      session[:cart].clear
      redirect_to order_comfirm_path
    else
      render :new
    end


  end

  private

  
end
