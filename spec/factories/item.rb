FactoryBot.define do
  factory :item do
    name { Faker::Games::Pokemon.name }
    description { Faker::TvShows::NewGirl.quote}
    unit_price { Faker::Number.decimal(l_digits: 2)}
    merchant
  end
end
