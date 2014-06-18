class CommitteeSession < ActiveRecord::Base
  belongs_to :committee
  has_one :conference, through: :committee

  validates_presence_of :committee
end
