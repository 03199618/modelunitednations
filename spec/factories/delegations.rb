# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :delegation do
    conference_id 1
    name "MyText"
    ambassador_id 1
  end
end
