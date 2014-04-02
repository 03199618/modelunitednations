# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :delegate do
    participant_id 1
    delegation_id 1
    comittee_id 1
  end
end
