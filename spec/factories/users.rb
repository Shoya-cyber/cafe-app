FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    name_reading { 'スズキ　タロウ' }
    email { Faker::Internet.free_email }
    phone_number { '09012345678' }
    birth_date { '1930-1-1' }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end