FactoryGirl.define do
  factory :auction do
    sequence(:title) { |number| "#{Faker::Company.bs} #{number}" }
    details Faker::Lorem.sentence
    ends_on { Date.today - Faker::Number.number(3).to_i.days }
    reserve_price 100
    current_price 0
    association :user, factory: :user
  end
end


