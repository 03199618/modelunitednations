class Registration < ActiveRecord::Base

  belongs_to :participant_group_member
  belongs_to :user
  belongs_to :conference
  belongs_to :group_registration

  scope :open, -> { where(withdrawn: false) }

  validates_presence_of :conference_id, :participant_group_member_id, :user_id

  validate :uniqueness

  def uniqueness
    if Registration.where(user_id: self.user_id, conference_id: self.conference_id).any? && !accepted
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
