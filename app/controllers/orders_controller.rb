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
    cart_session
    total_price = 0
    total_quantity = 0
    @cart.each do |cart|
      total_price += cart[:sub_total]
      total_quantity += cart[:quantity]
    end
        
    @order = Order.create(
      user_id: current_user.id,
      address_id: current_user.address.id,
      card_id: current_user.card.id,
      total_quantity: total_quantity,
      total_price: total_price
    )
    
    @cart.each do |cart|
      @order_detail = OrderDetail.create(
        order_id: @order.id,
        product_id: cart[:product_id],
        quantity: cart[:quantity]
      )
    end
    
    if @order.save && @order_detail.save
      charge
      session[:cart].clear
      redirect_to orders_complete_path
    else
      render :new
    end


  end

  private

  def cart_session
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

  def charge
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_id = current_user.card.customer_id
    Payjp::Charge.create(
      amount: @order.total_price,
      customer: customer_id,
      currency: 'jpy'
    )
  end



end
