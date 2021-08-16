class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show

  def show
    @user = User.find(params[:id])
    move_to_root

    if @user.address.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      card = Card.find_by(user_id: @user.id)
      customer= Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.first
    end

  end

  private

  def move_to_root
    unless user_signed_in? && @user.id == current_user.id
      redirect_to root_path
    end
  end
end
