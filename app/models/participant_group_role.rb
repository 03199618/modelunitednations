class ParticipantGroupRole < ActiveRecord::Base
  has_and_belongs_to_many :participant_group_members
  validates_presence_of :name
end
