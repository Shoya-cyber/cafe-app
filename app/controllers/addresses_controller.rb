class AddressesController < ApplicationController
  def edit
    @address = Address.find(current_user.address.id)
  end

  def update
    @address = Address.find(current_user.address.id)
    if @address.update(address_params)
    redirect_to user_path
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name).merge(user_id: current_user.id)
  end
end
