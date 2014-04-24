class CommitteeRole < ActiveRecord::Base
  has_and_belongs_to_many :committee_members, join_table: "committee_members_committee_roles"
  validates_presence_of :name
end
