class ParticipantGroupMember < ActiveRecord::Base
  belongs_to :participant_group
  belongs_to :user
  has_one :participant
  has_and_belongs_to_many :participant_group_roles, join_table: "participant_group_roles_participant_group_member"
  has_one :delegation, through: :participant

  def addParticipantGroupRole(participant_group_role_title)
    participant_group_role = ParticipantGroupRole.find_by_name(participant_group_role_title)
    if participant_group_role.nil?
      errors[:base] << "Participant group '#{participant_group_role_title}' role not found."
      return
    end
    self.participant_group_roles << participant_group_role
  end

  def name
    name = self.user.name
    name = name + ", " + self.participant_group_roles.first.name.capitalize unless self.participant_group_roles.first.name == "member"
    return name
  end

end
