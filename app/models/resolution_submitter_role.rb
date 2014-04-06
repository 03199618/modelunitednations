class ResolutionSubmitterRole < ActiveRecord::Base
  has_and_belongs_to_many :resolution_submitter, join_table: "resolution_submitter_roles_resolution_submitters"
  validates_presence_of :name
end
