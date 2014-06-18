class Topic < ActiveRecord::Base
  has_and_belongs_to_many :resolutions
  has_and_belongs_to_many :committees
  validates_presence_of :name

  def addResolution(resolution)
    self.resolutions << resolution
  end

  def conference
    comittees.first.conference
  end

  def comittee
    comittees.first
  end
end
