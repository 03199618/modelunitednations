class GroupRegistration < ActiveRecord::Base
  belongs_to :participant_group
  belongs_to :conference
  has_many :registrations

  after_save :register_participant_group_members

  validate :uniqueness

  def uniqueness
    if GroupRegistration.where(participant_group_id: self.participant_group_id, conference_id: self.conference_id).any? && !accepted
      errors[:base] << "You have already registered at #{conference.name}."
    end
  end

  def withdraw
    self.withdrawn = true
  end

  def accept
    self.accepted = true
    conference.addParticipantGroup(participant_group)

  end

  def name
    name = participant_group.name
    name = name + " at "
    name = name + conference.acronym
    name = name + " (withdrawn)" unless !withdrawn
    name = name + " (accepted)" unless !accepted
    return name
  end

  private

  def register_participant_group_members
    participant_group.participant_group_members.each do |m|
      registration = Registration.new(user_id: m.user_id, participant_group_member_id: m.id, conference_id: self.conference.id, group_registration_id: self.id)
      registration.save
    end
  end

end
