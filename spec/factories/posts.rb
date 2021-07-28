FactoryBot.define do
  factory :post do
    post_category_id  { 2 }
    title             { Faker::String.random(length: 50)}
    text              { Faker::Lorem.sentence }
    association       :user

    after(:build) do |post|
      post.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end