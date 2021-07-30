FactoryBot.define do
  factory :product do
    product_name { Faker::Coffee.blend_name }
    info         { Faker::Lorem.sentence }
    price        { Faker::Number.number }

    after(:build) do |post|
      post.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
