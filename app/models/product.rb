class Product < ApplicationRecord
  has_one_attached :image

  with_options presence: true do 
    validates :product_name
    validates :info, length: { maximum: 50}
    validates :price, format: { with: /\A[0-9]+\z/, massage: 'is invalid. Input half-width characters.' }
    validates :image
  end
  validates :price, numericality: { only_integer: true, other_than: 0, massage: 'is invalid. Input half-width characters.' }
end
