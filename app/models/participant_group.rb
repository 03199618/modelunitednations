class ParticipantGroup < ActiveRecord::Base
  belongs_to :conference
  has_and_belongs_to_many :participant_group_members

  validates_presence_of :name

  def addManager(user)
    participant_group_member = ParticipantGroupMember.new(user_id: user.id)
    participant_group_member.addParticipantGroupRole("manager")

    self.participant_group_members << participant_group_member
  end
end
