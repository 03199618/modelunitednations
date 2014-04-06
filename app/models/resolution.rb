class Resolution < ActiveRecord::Base
  has_and_belongs_to_many :topics
  belongs_to :comittee
  has_many :resolution_submitters, class_name: "ResolutionSubmitter", foreign_key: "resolution_id"

  def main_submitter
    #resolution_submitters.joins(:resolution_submitter_roles).where(resolution_submitter_roles: {name: "mainsubmitter"}).first
    resolution_submitters.first
  end

  def topic
    topics.first.name
  end

  def addResolutionSubmitter(delegate, role)
    puts delegate.inspect
    resolution_submitter = ResolutionSubmitter.new(delegate_id: delegate.id)
    resolution_submitter.addResolutionSubmitterRole(role)
    resolution_submitter.resolution_id = self.id
    resolution_submitter.save
  end
end
