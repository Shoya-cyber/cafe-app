FactoryBot.define do
  factory :order do
    total_quantity { 5 }
    total_price { 2000 }
    association :user
    association :card
    association :address
  end
end
