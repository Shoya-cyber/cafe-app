class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :post_category

  has_one_attached :image
  belongs_to :user

  with_options presence: true do
    validates :post_category 
    validates :title, length: { maximum: 50}
    validates :text
    validates :image
  end
  validates :post_category_id, numericality: { other_than: 1}
end
