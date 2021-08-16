class AddressesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_address, only: [:edit, :update]
  before_action :move_to_user_show, only: [:edit, :update]

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :house_number,
                                    :building_name).merge(user_id: current_user.id)
  end

  def move_to_user_show
    redirect_to user_path(current_user.id) unless user_signed_in? && current_user.id == @address.user_id
  end

  def set_address
    @address = Address.find(current_user.address.id)
  end
end
