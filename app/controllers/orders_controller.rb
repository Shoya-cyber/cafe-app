class OrdersController < ApplicationController

  def customer_info
    @order = Order.new
  end
end
