class GroupRegistration < ActiveRecord::Base
  belongs_to :participant_group
  belongs_to :conference
  has_many :registrations

  after_save :register_participant_group_members

  validate :uniqueness

  def uniqueness
    if self.new_record? && GroupRegistration.where(participant_group_id: self.participant_group_id, conference_id: self.conference_id).any? && !accepted
      errors[:base] << "You have already registered at #{conference.name}."
    end
  end

  def withdraw
    self.withdrawn = true
    self.registrations.each do |registration|
      registration.withdraw

      if !registration.save
        errors[:base] << "Registration of #{registration.user.name} could not be withdrawn."
      end
    end
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

  def status
    return "withdrawn" unless !withdrawn
    return "rejected" unless !rejected
    return "accepted" unless !accepted
    return "pending"
  end

  private

  def register_participant_group_members
    participant_group.participant_group_members.each do |m|
      self.conference.addRegistration(m.user, m, self)
    end
  end

end
