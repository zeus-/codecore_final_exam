FactoryGirl.define do
  factory :bid do
    price Faker::Number.number(2)
    association :auction, factory: :auction
    association :user, factory: :user
  end
end

