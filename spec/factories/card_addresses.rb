FactoryBot.define do
  factory :card_address do
    card_id {"tok_abcdefghijk00000000000000000"}
    customer_id {'cus_abcdefghijk00000000000000000'}
    postal_code {'1234567'}
    prefecture_id { 2 }
    city { '東京都' }
    house_number { '1-1-1' }
    building_name { '東京マンション'}
  end
end
