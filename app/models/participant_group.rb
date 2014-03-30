class ParticipantGroup < ActiveRecord::Base
  belongs_to :conference
  has_and_belongs_to_many :participants
end
