class Comittee < ActiveRecord::Base
  include PublicActivity::Model
  tracked except: :create

  has_and_belongs_to_many :participants
  has_many :delegates
  belongs_to :conference

  validates_presence_of :name
end

