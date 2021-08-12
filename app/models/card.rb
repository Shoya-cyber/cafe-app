class Card < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :nullify

  with_options presence: true do
    validates :card_id
    validates :customer_id
  end
end
