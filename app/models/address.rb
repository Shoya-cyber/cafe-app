class Address < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :nullify
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{7}\z/, message: 'is invalid. Not include hyphen(-).' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank." }
    validates :city
    validates :house_number
  end
end
