# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conference do
    name "Conference #{Faker::Name.name}"
  end
end
