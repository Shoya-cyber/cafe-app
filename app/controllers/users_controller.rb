class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: @user.id)
    customer= Payjp::Customer.retrieve(card.customer_id)
    @card = customer.cards.first

  end
end
