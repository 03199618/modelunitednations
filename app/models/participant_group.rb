class ParticipantGroup < ActiveRecord::Base

  has_many :participant_group_members
  has_many :group_registrations

  validates_presence_of :name

  def conferences
    return Conference.join(:group_registrations).where(group_registrations: {participant_group_id: self.id, accepted: true})
  end

  def manager
    self.participant_group_members.join(:participant_group_role).where(participant_group_role: {name: "manager"}).first.user
  end

  def addManager(user)
    return addParticipantGroupMember(user, "manager")
    participant_group_member = ParticipantGroupMember.new(user_id: user.id, participant_group_id: self.id)
    participant_group_member.addParticipantGroupRole("manager")
    participant_group_member.save
  end

  def key(email)
    return Digest::MD5.hexdigest(self.created_at.time.to_i.to_s+email)
  end


  def join(user, key)
    if self.key(user.email) == key

      return self.addParticipantGroupMember(user)
    else
      return false
    end
  end

  def addParticipantGroupMember(user, role = "member")
    if ParticipantGroupMember.where(user_id: user.id, participant_group_id: self.id).any?
      return false
    else
      participant_group_member = ParticipantGroupMember.new(user_id: user.id, participant_group_id: self.id)
      participant_group_member.addParticipantGroupRole(role)
      participant_group_member.save
      return true
    end
  end

  def member?(user)
    return self.participant_group_members.map(&:user_id).include? user.id
  end
end
