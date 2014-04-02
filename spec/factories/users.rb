# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    name Faker::Name.name
    email
    password "changeme"
    password_confirmation "changeme"
  end
end
