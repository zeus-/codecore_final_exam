FactoryGirl.define do
  factory :user do
    user_name Faker::Name.first_name
    sequence(:email) {|n| "some_email#{n}@bidr.com" }
    # password Faker::Internet.password
    password "foodbars"
    password_confirmation "foodbars"
  end
end
