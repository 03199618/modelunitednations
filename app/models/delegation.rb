class Delegation < ActiveRecord::Base
  belongs_to :conference
  has_one :ambassador, class_name: "Participant", foreign_key: "ambassador"
  has_many :participants
end
