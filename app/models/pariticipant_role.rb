class PariticipantRole < ActiveRecord::Base
  has_and_belongs_to_many :participant, join_table: "participants_participant_roles"
end
