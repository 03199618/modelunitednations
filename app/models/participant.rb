class Participant < ActiveRecord::Base
  include PublicActivity::Model
  tracked except: [:create, :destroy]

  has_and_belongs_to_many :participant_roles, join_table: "participants_participant_roles"

  belongs_to :conference
  belongs_to :participant_group_member
  belongs_to :user
  has_many :delegation_members

  has_many :committee_members
  has_many :committees, through: :committee_members


  before_save :role

  def role
    if participant_roles.none?
      addParticipantRole("delegate")
    end
  end

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

    if user.nil?
      return self.participant_roles.first.name.capitalize
    else
      name = self.user.name
      name = name + ", " + self.participant_roles.first.name.capitalize unless self.participant_roles.first.name == "delegate"
      return name
    end
  end

end
