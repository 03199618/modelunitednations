class ParticipantGroup < ActiveRecord::Base
  belongs_to :conference
  has_many :participant_group_members
  has_many :registrations

  validates_presence_of :name

  def addManager(user)
    participant_group_member = ParticipantGroupMember.new(user_id: user.id, participant_group_id: self.id)
    participant_group_member.addParticipantGroupRole("manager")
    participant_group_member.save
    puts participant_group_member.inspect
  end
end
