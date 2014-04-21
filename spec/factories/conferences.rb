# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conference do
    name "Conference #{Faker::Name.name}"
    street "MUN Street"
    city "Munich"
    zipcode "88888"
    state "Bavaria"
    country "Germany"
  end
end
