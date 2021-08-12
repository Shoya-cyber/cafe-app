class Order < ApplicationRecord

  belongs_to :user
  belongs_to :address
  belongs_to :card
  attr_accessor :token

  has_many :products, through: :order_details
  has_many :order_details, dependent: :destroy

  with_options presence: true do
    validates :total_quantity
    validates :total_price
  end
end
