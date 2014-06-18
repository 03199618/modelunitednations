# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :committee_member do
    committee_id 1
    participant_id 1
    committee_role_id 1
  end
end
