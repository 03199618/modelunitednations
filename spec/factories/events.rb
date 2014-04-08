# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    timetable_id 1
    starts_at "2014-04-08 21:51:09"
    ends_at "2014-04-08 21:51:09"
    name "MyString"
    description Faker::Lorem.paragraph
  end
end
