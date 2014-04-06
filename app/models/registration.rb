class Registration < ActiveRecord::Base

  belongs_to :participant_group
  belongs_to :conference

  scope :open, -> { where(withdrawn: false) }

  validates_presence_of :conference, :participant_group

  validate :uniqueness

  def uniqueness
    if Registration.where(participant_group_id: self.participant_group_id, conference_id: self.conference_id).any? && !accepted
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
    name = conference.name
    name = name + " (withdrawn)" unless !withdrawn
    name = name + " (accepted)" unless !accepted
    return name
  end
end
