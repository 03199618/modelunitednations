class Comittee < ActiveRecord::Base
  include PublicActivity::Model
  tracked except: :create

  belongs_to :conference

  has_many :resolutions
  has_many :delegates
  has_many :comittee_sessions
  has_many :committee_members

  has_many :announcements, as: :announced_at

  has_and_belongs_to_many :topics
  has_and_belongs_to_many :participants


  validates_presence_of :name

  def addTopic(topic)
    topic = Topic.find(topic.id)
    self.topics << topic
  end

  def deadline_position_paper
    return 1
  end

  def chairs
    self.committee_members.joins(:committee_roles).where(committee_roles: {name: "chair"} )
  end

  def chair?(participant)
    return self.committee_members.joins(:committee_roles).where(committee_roles: {name: "chair"} ).map(&:id).include? participant.id
  end

  def delegate?(participant)
    return self.committee_members.joins(:committee_roles).where(committee_roles: {name: "delegate"} ).map(&:id).include? participant.id
  end

  def delegates
    self.committee_members.joins(:committee_roles).where(committee_roles: {name: "delegate"} )
  end

  def addChair(participant)
    return addMember(participant, "chair")
  end

  def addDelegate(participant)
    return addMember(participant, "delegate")
  end

  def addMember(participant, role = "delegate")
    if self.committee_members.where(participant_id: participant.id).any?
      return false
    else
      committee_member = self.committee_members.new(participant_id: participant.id)
      committee_member.addRole(role)
      committee_member.save
      return true
    end
  end
end

