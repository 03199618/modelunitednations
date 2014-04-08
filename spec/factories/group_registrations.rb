# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group_registration do
    conference_id 1
    participant_group_id 1
    withdrawn false
    accepted false
    rejected false
  end
end
