class Comittee < ActiveRecord::Base
  include PublicActivity::Model
  tracked except: :create

  has_many :resolutions
  has_and_belongs_to_many :participants
  has_many :delegates
  belongs_to :conference
  has_and_belongs_to_many :topics

  validates_presence_of :name

  def addTopic(topic)
    topic = Topic.find(topic.id)
    self.topics << topic
  end
end

