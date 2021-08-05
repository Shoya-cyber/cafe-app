class Order < ApplicationRecord

  belongs_to :user

  with_options presence: true do
    validates :total_quantity
    validates :total_price
  end
end
