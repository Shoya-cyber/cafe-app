class Order < ApplicationRecord

  belongs_to :user
  has_many :products, through: :order_details
  has_many :order_details, dependent: :destroy

  with_options presence: true do
    validates :total_quantity
    validates :total_price
  end
end
