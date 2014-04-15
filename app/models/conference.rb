class Conference < ActiveRecord::Base
  include PublicActivity::Model
  tracked except: [:create, :destroy]

  has_many :announcements, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :delegations, dependent: :destroy
  has_many :delegates, through: :delegations
  has_many :comittees, dependent: :destroy
  has_many :participant_groups
  has_many :registrations, dependent: :destroy
  has_many :group_registrations, dependent: :destroy
  has_many :timetables

  validates_presence_of :name

  def should_have_timetable

  end
  def timetable
    result = timetables.first
    if result.nil?
      new_timetable = self.timetables.new
      new_timetable.save
      result = new_timetable
    end
    return result
  end

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
    participant = Participant.new(participant_group_member_id: participant_group_member.id, user_id:participant_group_member.user.id,)
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

  def acronym
    if read_attribute(:acronym).nil?
      return name
    else
      return acronym
    end
  end

  def name
    if read_attribute(:acronym).nil?
      return name_helper
    else
      return name_helper + " (#{acronym})"
    end
  end

  private

  def name_helper
    if read_attribute(:name).nil?
      return "#{self.managers.first.name}'s Conference"
    else
      return read_attribute(:name)
    end
  end
end
