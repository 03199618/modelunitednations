class Conference < ActiveRecord::Base
  include PublicActivity::Model
  tracked except: :create

  has_many :announcements
  has_many :participants
  has_many :delegations
  has_many :delegates, through: :delegations
  has_many :comittees
  has_many :participant_groups
  has_many :registrations

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

  def addParticipantGroup(participant_group)
    participant_group.participant_group_members.each do |participant_group_member|
      addParticipant(participant_group_member)
    end
  end

  def addParticipant(participant_group_member)
    participant = Participant.new(participant_group_member_id: participant_group_member.id)
    self.participants << participant
  end


  def participantForUser(user)
    participant = Participant.where(user_id: user.id).first
  end

  def placards
    pdf = Prawn::Document.new
    delegates.each do |delegate|
      move 100,100
      pdf.text "#{delegate.delegation.name}", rotate: 90
      move 200,200
      pdf.text "#{delegate.delegation.name}", rotate: -90
      start_new_page
    end
    return pdf
  end
end
