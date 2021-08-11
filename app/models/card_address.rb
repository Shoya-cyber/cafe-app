class CardAddress
  include ActiveModel::Model
  attr_accessor :card_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :user_id, :customer_id

  with_options presence: true do
    validates :card_id
    validates :customer_id
    validates :postal_code, format: { with: /\A\d{7}\z/, message: "is invalid. Not include hyphen(-)." }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank." }
    validates :city
    validates :house_number
  end

  def save
    Card.create(card_id: card_id, user_id: user_id, customer_id: customer_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, user_id: user_id)
  end


end
