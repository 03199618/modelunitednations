class Conference < ActiveRecord::Base
  include PublicActivity::Model
  tracked

  has_many :announcements
  has_many :participants
  has_many :delegations
  has_many :comittees
  has_many :participant_groups

  validates :name, presence: true

  def managers
    self.participants.joins(:participant_roles).where(participant_roles: {name: "manager"} )
  end

  def delegates
    self.participants.joins(:participant_roles).where(participant_roles: {name: "delegate"} )
  end

  def addManager(user)
    participant = Participant.new(user_id: user.id)
    participant.addParticipantRole("manager")

    self.participants << participant
  end

  def addDelegate(user)
    participant = Participant.new(user_id: user.id)
    participant.addParticipantRole("delegate")

    self.participants << participant
  end

  def participantForUser(user)
    participant = Participant.where(user_id: user.id).first
  end
end
