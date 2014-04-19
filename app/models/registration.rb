class Registration < ActiveRecord::Base

  belongs_to :participant_group_member
  belongs_to :user
  belongs_to :conference
  belongs_to :group_registration

  scope :open, -> { where(withdrawn: false, rejected: false, accepted: false) }
  scope :accepted, -> { where(accepted: true) }
  scope :rejected, -> { where(rejected: true) }
  scope :withdrawn, -> { where(withdrawn: true) }

  validates_presence_of :conference_id, :user_id

  validate :uniqueness

  def uniqueness
    if Registration.where(user_id: self.user_id, conference_id: self.conference_id).any? && !accepted
      errors[:base] << "You have already registered at #{conference.name}."
    end
  end

  def participant_group
    participant_group_member.participant_group
  end

  def withdraw
    self.withdrawn = true
  end

  def accept
    if conference.participant?(self.user)
      errors[:base] << "This person is already participating at #{conference.name}."
      return false
    else
      self.accepted = true
      conference.addParticipant(self.user)
      return true
    end
  end

  def name
    name = user.name
    name = name + " at "
    name = name + conference.acronym
    name = name + " (withdrawn)" unless !withdrawn
    name = name + " (accepted)" unless !accepted
    return name
  end
end
