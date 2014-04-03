class ParticipantGroupMember < ActiveRecord::Base
  has_and_belongs_to_many :participant_groups, join_table: "participant_groups_participant_group_members"
  belongs_to :user
  has_and_belongs_to_many :participant_group_roles

  def addParticipantGroupRole(participant_group_role_title)
    participant_group_role = ParticipantGroupRole.find_by_name(participant_group_role_title)
    if participant_group_role.nil?
      errors[:base] << "Participant group '#{participant_group_role_title}' role not found."
      return
    end
    self.participant_group_role << participant_group_role
  end

  def name
    user.name
  end

end
