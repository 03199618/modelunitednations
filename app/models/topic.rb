class Topic < ActiveRecord::Base
  has_and_belongs_to_many :resolutions
  has_and_belongs_to_many :comittees
  validates_presence_of :name
end
