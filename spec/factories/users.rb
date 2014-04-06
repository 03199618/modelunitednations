# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    firstname Faker::Name.first_name
    surname Faker::Name.last_name
    email
    password "changeme"
    password_confirmation "changeme"
  end
end
