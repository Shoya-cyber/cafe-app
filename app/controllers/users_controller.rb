class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    if @user.address.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      card = Card.find_by(user_id: @user.id)
      customer= Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.first
    end

  end

  private

  def card

  end
end
