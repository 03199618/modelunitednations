class Participant < ActiveRecord::Base
  include PublicActivity::Model
  tracked

  has_and_belongs_to_many :participant_roles, join_table: "participants_participant_roles"
  has_and_belongs_to_many :comittees
  belongs_to :delegation
  belongs_to :conference
  belongs_to :user

  def initial_role=(role_name)
    @initial_role = role_name
    role = Role.find_by_name(role_name)
    self.roles << role
  end

  def has_role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def addParticipantRole(participant_role_title)
    participant_role = ParticipantRole.find_by_name(participant_role_title)
    if participant_role.nil?
      errors[:base] << "Participant '#{participant_role_title}' role not found."
      return
    end
    self.participant_roles << participant_role
  end

  def name
    if user
      return self.user.name
    else
      return self.participant_roles.first.name
    end
  end

end
