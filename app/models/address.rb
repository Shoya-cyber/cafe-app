class Address < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{7}\z/, message: "is invalid. Not include hyphen(-)." }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank." }
    validates :city
    validates :house_number
  end
end
