FactoryGirl.define do
  factory :admin_user do
    name "John Doe"
    phone_number "+923234035166"
    address "The Address"
    sequence(:email) { |n| "person-#{n}@example.com" }
    sequence(:username) { |n| "user0#{n}" }
    password "password"
    password_confirmation "password"
  end
end


