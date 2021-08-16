class CardAddressesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :move_to_root, only: [:new, :create]

  def new
    @card_address = CardAddress.new
  end

  def create
    @card_address = CardAddress.new(card_address_params)

    if @card_address.valid?
      @card_address.save
      if session[:cart].blank?
        redirect_to user_path(current_user.id)
      else
        redirect_to new_order_path
      end
    else
      render :new
    end
  end

  private

  def card_params
    params.require(:card_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name).merge(
      card_id: params[:card_id], user_id: current_user.id
    )
  end

  def card_address_params
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer = Payjp::Customer.create(description: 'test', card: card_params[:card_id])
    params.require(:card_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name).merge(
      card_id: params[:card_id],
      user_id: current_user.id,
      customer_id: customer.id
    )
  end

  def move_to_root
    redirect_to root_path if current_user.address.present? || current_user.card.present?
  end
end
