class ComitteeSession < ActiveRecord::Base
  belongs_to :comittee
  has_one :conference, through: :comittee

  validates_presence_of :comittee
end
